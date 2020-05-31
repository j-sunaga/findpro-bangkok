class UsersController < ApplicationController
  before_action :set_user, only: %i[show myprofile]

  def show
    @conversation = Conversation.between(@user, current_user)
  end

  def professional
    @categories = Category.all
    @users = if params[:search].present?
               User.applicants.search(params[:keyword], params[:category], params[:page])
             else
               User.page(params[:page]).applicants
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
end
