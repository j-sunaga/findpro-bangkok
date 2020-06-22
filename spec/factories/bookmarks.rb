FactoryBot.define do
  factory :bookmark do
    post
    user factory: :applicant
  end
end
