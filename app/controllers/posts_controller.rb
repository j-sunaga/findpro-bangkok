class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update select_user destroy]
  before_action :authenticate_user!, only: %i[index new edit update destroy]
  before_action :check_recruiter, only: %i[myposts select_user new edit update destroy]

  def index
    @posts = Post.page(params[:page]).all
    @categories = Category.all
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
    @comments = @post.comments
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
      redirect_to @post, notice: 'タスクの登録が完了しました'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'タスクの更新が完了しました'
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @post.recruiter.id
      if @post.destroy!
        redirect_to posts_url, notice: 'タスクを削除しました'
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
end
