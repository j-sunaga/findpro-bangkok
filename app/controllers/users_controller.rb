class UsersController < ApplicationController

  def show
  def applicant_index
    @users = User.page(params[:page]).where(applicant_or_recruiter: 'applicant')
    @categories = Category.all
  end

    @user = User.find(params[:id])
  end

end
