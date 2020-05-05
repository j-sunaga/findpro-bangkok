class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    user_model_attributes = %i[name profile_image profile_image_cache remove_profile_image content applicant_or_recruiter admin]
    devise_parameter_sanitizer.permit(:sign_up, keys: user_model_attributes)
  end
end
