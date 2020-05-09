class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit; end

  def show; end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: 'Successfully create Category'
    else
      flash[:danger] = 'Failed to save'
      render :new
    end
  end

  def update
    destroy_all_posts if params[:category][:post_ids].blank?
    destroy_all_users if params[:category][:user_ids].blank?
    if @category.update(category_params)
      redirect_to @category, notice: 'Successfully update Category'
    else
      flash[:danger] = 'Failed to update'
      render :edit
    end
  end

  def destroy
    @category.destroy!
    redirect_to categories_url, notice: 'Delete category'
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, post_ids: [], user_ids: [])
  end

  def destroy_all_posts
    @category.posts.destroy_all
  end

  def destroy_all_users
    @category.users.destroy_all
  end
end
