class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new edit update destroy]

  def index
    @posts = Post.all
  end

  def myposts
    @posts = current_user.posts
  end

  def show
    @comments = @post.comments
    @comment = @post.comments.build
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = current_user.posts.build(post_params)
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
    params.require(:post).permit(:title, :detail, :post_image, :post_image_cache, :deadline, :status, category_ids: [])
  end
end
