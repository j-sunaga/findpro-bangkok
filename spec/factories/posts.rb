FactoryBot.define do
  factory :post do
    sequence :title do |n|
      "post_#{1}"
    end

    sequence :detail do |n|
      "post_#{n}_detail"
    end
    post_image{"no_image.jpg"}
    deadline { 1.month.ago }
    status { :open }

  end
end
