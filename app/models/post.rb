# frozen_string_literal: true

class Post < ApplicationRecord
  class << self; undef :open; end

  belongs_to :recruiter, class_name: 'User', foreign_key: :recruiter_id
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_users, through: :bookmarks, source: :user
  has_many :applications, dependent: :destroy
  has_many :application_users, through: :applications, source: :user
  has_many :category_posts, dependent: :destroy
  has_many :categories, through: :category_posts, source: :category

  validates :title, presence: true, length: { in: 1..50 }
  validates :detail, length: { in: 1..1000 }
  validates :status, presence: true

  enum status: { open: 0, closed: 1 }
  mount_uploader :post_image, ImageUploader
end
