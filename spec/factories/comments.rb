FactoryBot.define do
  factory :comment do
    sequence :content do |n|
      "comment_#{n}"
    end
    user { nil }
    post { nil }
  end
end
