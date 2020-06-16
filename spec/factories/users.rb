FactoryBot.define do
  factory :applicant, class: User do
    sequence :name do |n|
      "applicant_#{n}"
    end
    sequence :email do |n|
      "applicant_#{n}@example.com"
    end
    sequence :content do |n|
      "applicant_#{n}_content"
    end
    password { '123456' }
    applicant_or_recruiter { :applicant }
    admin { false }
  end
  factory :recruiter, class: User do
    sequence :name do |n|
      "recruiter_#{n}"
    end
    sequence :email do |n|
      "recruiter_#{n}@example.com"
    end
    sequence :content do |n|
      "recruiter_#{n}_content"
    end
    password { '123456' }
    applicant_or_recruiter { :recruiter }
    admin { false }
  end
  factory :admin, class: User do
    sequence :name do |n|
      "admin_#{n}"
    end
    sequence :email do |n|
      "admin_#{n}@example.com"
    end
    profile_image { 'no_image.jpg' }
    password { '123456' }
    applicant_or_recruiter { :recruiter }
    admin { true }
  end
end
