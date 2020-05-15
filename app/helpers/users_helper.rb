module UsersHelper

  def check_recruiter
    if current_user.applicant?
      redirect_back(fallback_location: root_path, notice: 'no permission')
    end
  end

  def check_applicant
    if current_user.recruiter?
      redirect_back(fallback_location: root_path, notice: 'no permission')
    end
  end

end
