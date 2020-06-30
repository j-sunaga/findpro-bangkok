class ApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_applicant

  def create
    application = current_user.applications.build(post_id: params[:post_id])
    if application.save
      # ApplyMailer.apply_mail(current_user, application.post).deliver
      redirect_back(fallback_location: root_path, notice: 'Successfully Applied')
    else
      render fallback_location
    end
  end

  def index
    @posts = current_user.application_posts.order(status: :asc).order(:deadline)
  end

  def destroy
    application = current_user.applications.find(params[:id])
    if application.destroy!
      redirect_back(fallback_location: root_path, notice: 'Un-Applied')
    else
      render fallback_location
    end
  end
end
