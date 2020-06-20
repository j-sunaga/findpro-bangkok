FactoryBot.define do
  factory :category_post do
    association :post
    association :category
  end
end
