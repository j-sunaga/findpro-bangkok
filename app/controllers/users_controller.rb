class UsersController < ApplicationController
  before_action :set_user, only: %i[show myprofile]
  before_action :check_profile_owner, only: %i[myprofile]

  def show
    @conversation = Conversation.between(@user, current_user)
  end

  def professional
    @categories = Category.all
    if params[:category].present?
      @q = User.applicants.ransack(params[:q])
      @users = @q.result.category_users(params[:category]).order(created_at: 'DESC').page(params[:page])
      @category = Category.find_by(name: params[:category])
    else
      @q = User.applicants.ransack(params[:q])
      @users = @q.result.order(created_at: 'DESC').page(params[:page])
    end
  end

  def selected_posts
    @posts = current_user.selected_posts
  end

  def myprofile; end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def check_profile_owner
    return if @user.id == current_user.id

    flash[:alert] = 'no permission'
    redirect_back(fallback_location: root_path)
  end
end
