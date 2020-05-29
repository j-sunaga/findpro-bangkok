class UsersController < ApplicationController
  before_action :set_user, only: %i[show myprofile]

  def show
    @conversation = Conversation.between(@user, current_user)
  end

  def professional
    @users = User.page(params[:page]).where(applicant_or_recruiter: 'applicant')
    @categories = Category.all
  end

  def myprofile; end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
