require 'rails_helper'
RSpec.describe '募集機能', type: :model do
  it 'titleが空ならバリデーションが通らない' do
    post = build(:post, title:'')
    expect(post).to be_invalid
  end
  it 'titleが51文字以上ならバリデーションが通らない' do
    post = build(:post, title: 'a'*51)
    expect(post).to be_invalid
  end
  it 'detailが1001文字以上ならバリデーションが通らない' do
    post = build(:post, detail: 'a'*1001)
    expect(post).to be_invalid
  end
  it 'deadlineがnilならバリデーションが通らない' do
    post = build(:post, deadline: nil)
    expect(post).to be_invalid
  end
  it 'deadlineが過去の日付ならバリデーションが通らない' do
    post = build(:post, deadline: DateTime.now - 1.week)
    expect(post).to be_invalid
  end
  it 'statusがnilならバリデーションが通らない' do
    post = build(:post, status: nil)
    expect(post).to be_invalid
  end
  it 'statusがnilならバリデーションが通らない' do
    post = build(:post, status: nil)
    expect(post).to be_invalid
  end
  it 'titleが50文字/detailが1000字ならバリデーションが通る' do
    post = build(:post, title: 'a'*50, detail: 'a'*1000)
    expect(post).to be_valid
  end
end
