FactoryBot.define do
  factory :message do
    sequence :body do |n|
      "message_#{n}"
    end

    after(:build) do |message|
      message.conversation = create(:conversation)
      message.user = message.conversation.sender
    end

  end
end
