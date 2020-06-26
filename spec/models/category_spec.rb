require 'rails_helper'
RSpec.describe 'カテゴリ機能', type: :model do
  it 'nameが空ならバリデーションが通らない' do
    category = build(:category, name: '')
    expect(category).to be_invalid
  end
  it 'nameが51文字以上ならバリデーションが通らない' do
    category = build(:category, name: 'a' * 51)
    expect(category).to be_invalid
  end
  it '同じnameのカテゴリがある場合,バリデーションが通らない' do
    create(:category, name: 'category')
    category = build(:category, name: 'category')
    expect(category).to be_invalid
  end
  it 'nameが50文字以内ならバリデーションが通る' do
    category = build(:category, name: 'a' * 50)
    expect(category).to be_valid
  end
end
