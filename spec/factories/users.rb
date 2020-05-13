FactoryBot.define do
  factory :user do
    sequence :name do |n|
      "user_#{n}"
    end

    sequence :email do |n|
      "user_#{n}@example.com"
    end

    sequence :content do |n|
      "user_#{n}_content"
    end

    profile_image{"no_image.jpg"}
    password{"123456"}
    applicant_or_recruiter { :applicant }

  end
end
