FactoryBot.define do
  factory :category_user do
    user {}
    association :category
  end
end
