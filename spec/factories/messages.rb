FactoryBot.define do
  factory :message do
    sequence :body do |n|
      "message_#{n}"
    end

    conversation
    user { conversation.sender }

  end
end
