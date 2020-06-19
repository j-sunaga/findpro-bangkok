class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update select_user destroy]
  before_action :check_recruiter, only: %i[myposts application_users new]
  before_action :check_post_owner, only: %i[select_user edit update destroy]

  def index
    @categories = Category.all
    if params[:category].present?
      @q = Post.ransack(params[:q])
      @posts = @q.result.category_posts(params[:category]).order(status: :asc).order(:deadline).page(params[:page])
      @category = Category.find_by(name: params[:category])
    else
      @q = Post.ransack(params[:q])
      @posts = @q.result.order(status: :asc).order(:deadline).page(params[:page])
    end
  end

  def myposts
    @posts = current_user.recruiting_posts
  end

  def select_user
    if @post.update(selected_user_id: params[:selected_user_id])
      @post.update(status: 'closed')
      AssignMailer.assign_mail(User.find(params[:selected_user_id]), @post).deliver
      redirect_back(fallback_location: root_path, notice: 'Assign User!')
    else
      redirect_back(fallback_location: root_path, notice: 'Failed to Assign User!')
    end
  end

  def application_users
    @post = current_user.recruiting_posts.find(params[:id])
    @users = @post.application_users
  end

  def show
    @comments = @post.comments.order(created_at: :desc).page(params[:page])
    @comment = @post.comments.build
    @application_users = @post.application_users
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = current_user.recruiting_posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'complete post'
    else
      render :new
    end
  end

  def update
    destroy_all_categories if params[:post][:category_ids].blank?
    if @post.update(post_params)
      redirect_to @post, notice: 'complete updated'
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @post.recruiter.id
      if @post.destroy!
        redirect_to posts_url, notice: 'Sucessfully Delete Post'
      else
        redirect_to posts_url, notice: 'Failed to Delete'
      end
    else
      redirect_to posts_url, notice: 'No Permission to delete'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :detail, :post_image, :post_image_cache, :deadline, :status, :selected_user_id, :recruiter_id, category_ids: [])
  end

  def destroy_all_categories
    @posts.category_posts.destroy_all
  end

  def check_post_owner
    @post = Post.find(params[:id])
    return if @post.recruiter_id == current_user.id

    redirect_back(fallback_location: root_path, notice: 'no permission')
  end
end
