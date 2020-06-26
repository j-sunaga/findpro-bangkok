require 'rails_helper'

RSpec.describe User, type: :model do
  it 'nameが空ならバリデーションが通らない' do
    applicant = build(:applicant, name: '')
    expect(applicant).to be_invalid
  end
  it 'nameが51文字以上ならバリデーションが通らない' do
    applicant = build(:applicant, name: 'a' * 51)
    expect(applicant).to be_invalid
  end
  it 'emailが空ならバリデーションが通らない' do
    applicant = build(:applicant, email: '')
    expect(applicant).to be_invalid
  end
  it 'emailフォーマットが適切でない場合、バリデーションが通らない' do
    applicant = build(:applicant, email: 'aaaaa.com')
    expect(applicant).to be_invalid
  end
  it '同じemailの場合,バリデーションが通らない' do
    create(:applicant, email: 'b' * 50 + '@example.com')
    applicant2 = build(:applicant, email: 'b' * 50 + '@example.com')
    expect(applicant2).to be_invalid
  end
  it 'passwordが空ならバリデーションが通らない' do
    applicant = build(:applicant, password: '')
    expect(applicant).to be_invalid
  end
  it 'passwordが6文字未満ならバリデーションが通らない' do
    applicant = build(:applicant, password: '12345')
    expect(applicant).to be_invalid
  end
  it 'contentが1001文字以上ならバリデーションが通らない' do
    applicant = build(:applicant, content: 'a' * 1001)
    expect(applicant).to be_invalid
  end
  it 'applicant_or_recruiterがnilならバリデーションが通らない' do
    applicant = build(:applicant, applicant_or_recruiter: nil)
    expect(applicant).to be_invalid
  end
  it 'nameが50文字/contentが1000字ならバリデーションが通る' do
    applicant = build(:applicant, name: 'a' * 50, content: 'a' * 1000)
    expect(applicant).to be_valid
  end
end
