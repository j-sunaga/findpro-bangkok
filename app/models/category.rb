class Category < ApplicationRecord
  has_many :category_users, dependent: :destroy
  has_many :users, through: :category_users, source: :user
  has_many :category_posts, dependent: :destroy
  has_many :posts, through: :category_posts, source: :post
  validates :name, uniqueness: true

  scope :select_category, ->(category) { where('categories.name = ?', category) }
end
