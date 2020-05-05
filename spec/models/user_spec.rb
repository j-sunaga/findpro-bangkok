require 'rails_helper'

RSpec.describe User, type: :model do
  it 'nameが空ならバリデーションが通らない' do
    user = build(:user, name: '')
    expect(user).to be_invalid
  end
  it 'nameが51文字以上ならバリデーションが通らない' do
    user = build(:user, name: 'a' * 51)
    expect(user).to be_invalid
  end
  it 'emailが空ならバリデーションが通らない' do
    user = build(:user, email: '')
    expect(user).not_to be_valid
  end
  it 'emailフォーマットが適切でない場合、バリデーションが通らない' do
    user = build(:user, email: 'aaaaa.com')
    expect(user).not_to be_valid
  end
  it '同じemailの場合,バリデーションが通らない' do
    create(:user, email: 'b' * 50 + '@example.com')
    user2 = build(:user, email: 'b' * 50 + '@example.com')
    expect(user2).not_to be_valid
  end
  it 'passwordが空ならバリデーションが通らない' do
    user = build(:user, password: '')
    expect(user).not_to be_valid
  end
  it 'passwordが6文字未満ならバリデーションが通らない' do
    user = build(:user, password: '12345')
    expect(user).not_to be_valid
  end
  it 'contentが1001文字以上ならバリデーションが通らない' do
    user = build(:user, content: 'a' * 1001)
    expect(user).not_to be_valid
  end
  it 'applicant_or_recruiterがnilならバリデーションが通らない' do
    user = build(:user, applicant_or_recruiter: nil)
    expect(user).not_to be_valid
  end
  it 'nameが50文字/contentが1000字ならバリデーションが通る' do
    user = build(:user, name: 'a' * 50, content: 'a' * 1000)
    expect(user).to be_valid
  end
end
