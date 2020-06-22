FactoryBot.define do
  factory :application do
    post
    user factory: :applicant
  end
end
