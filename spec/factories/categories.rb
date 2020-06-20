FactoryBot.define do
  factory :category do
    sequence :name do |n|
      "category_#{n}"
    end
  end
end
