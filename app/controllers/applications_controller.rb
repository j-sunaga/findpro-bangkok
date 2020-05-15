class ApplicationsController < ApplicationController
  before_action :check_applicant

  def create
    application = current_user.applications.build(post_id: params[:post_id])
    if application.save
      redirect_back(fallback_location: root_path, notice: 'Successfully Applied')
    else
      render fallback_location
    end
  end

  def index
    @posts = current_user.application_posts
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
