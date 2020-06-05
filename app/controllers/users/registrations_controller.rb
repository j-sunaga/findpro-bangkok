class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!
  before_action :configure_account_update_params, only: [:update]

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:sign_in, :name, :profile_image, :profile_image_cache, :remove_profile_image, :content, :applicant_or_recruiter, :admin, category_ids: []])
  end

  def after_update_path_for(_resource)
    myprofile_user_path(id: current_user.id)
  end
end
