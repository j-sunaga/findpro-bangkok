require 'rails_helper'

RSpec.describe Message, type: :model do
  it 'bodyが255文字より大きいならバリデーションが通らない' do
    message = build(:message, body:'a'*256 )
    expect(message).to be_invalid
  end
  it 'bodyが空白ならバリデーションが通らない' do
    message = build(:message, body:'' )
    expect(message).to be_invalid
  end
  it 'bodyが255文字以内ならバリデーションが通る' do
    message = build(:message, body:'a'*255 )
    expect(message).to be_valid
  end
end
