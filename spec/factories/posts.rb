FactoryBot.define do
  factory :post do
    sequence :title do |n|
      "post_#{n}"
    end

    sequence :detail do |n|
      "post_#{n}_detail"
    end

    post_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
    deadline { DateTime.now + 1.week }
    status { :open }

    association :recruiter, factory: :recruiter
    selected_user {}

    after :create do |post|
      create(:category_post, post: post)
    end
  end
end
