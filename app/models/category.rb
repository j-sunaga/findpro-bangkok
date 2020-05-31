class Category < ApplicationRecord
  has_many :category_users, dependent: :destroy
  has_many :users, through: :category_users, source: :user
  has_many :category_posts, dependent: :destroy
  has_many :posts, through: :category_posts, source: :post

  scope :select_category, ->(category) { where('name = ?', category) }
end
