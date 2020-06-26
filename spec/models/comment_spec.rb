require 'rails_helper'
RSpec.describe 'コメント機能', type: :model do
  let!(:user) { create(:applicant) }
  let!(:post) { create(:post) }
  it 'contentが空ならバリデーションが通らない' do
    comment = build(:comment, content: '', user: user, post: post)
    expect(comment).to be_invalid
  end
  it 'contentが256文字以上ならバリデーションが通らない' do
    comment = build(:comment, content: 'a' * 256, user: user, post: post)
    expect(comment).to be_invalid
  end
  it 'contentが255文字以内ならバリデーションが通る' do
    comment = build(:comment, content: 'a' * 255, user: user, post: post)
    expect(comment).to be_valid
  end
end
