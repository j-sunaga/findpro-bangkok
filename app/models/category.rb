class Category < ApplicationRecord
  has_many :category_users, dependent: :destroy
  has_many :users, through: :category_users, source: :user
end
