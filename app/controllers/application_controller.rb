class ApplicationController < ActionController::Base
  include UsersHelper
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    user_attributes = [:sign_in, :name, :profile_image, :profile_image_cache, :remove_profile_image, :content, :applicant_or_recruiter, :admin, category_ids: []]
    devise_parameter_sanitizer.permit(:sign_up, keys: user_attributes)
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end
end
