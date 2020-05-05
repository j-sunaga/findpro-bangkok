class PostsController < ApplicationController

  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)
    if @post.save
      SignupMailer.signup_mail('Sunaga').deliver
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
    @post.destroy!
    redirect_to posts_url, notice: 'タスクを削除しました'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :detail, :post_image, :post_image_cache, :deadline, :status)
  end

end
