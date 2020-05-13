FactoryBot.define do
  factory :post do

    sequence :title do |n|
      "post_#{n}"
    end

    sequence :detail do |n|
      "post_#{n}_detail"
    end
    post_image{"no_image.jpg"}
    deadline { DateTime.now + 1.week }
    status { :open }

    association :recruiter, factory: :user
    association :selected_user, factory: :user

  end
end
