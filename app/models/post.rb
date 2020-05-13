# frozen_string_literal: true

class Post < ApplicationRecord
  class << self; undef :open; end

  belongs_to :recruiter, class_name: 'User', foreign_key: :recruiter_id
  belongs_to :selected_user, class_name: 'User', optional: true, foreign_key: :selected_user_id
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_users, through: :bookmarks, source: :user
  has_many :applications, dependent: :destroy
  has_many :application_users, through: :applications, source: :user
  has_many :category_posts, dependent: :destroy
  has_many :categories, through: :category_posts, source: :category
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { in: 1..50 }
  validates :detail, length: { in: 1..1000 }
  validates :status, presence: true
  validates :deadline, presence: true
  validate :deadline_cannot_save_in_the_past

  enum status: { open: 0, closed: 1 }
  mount_uploader :post_image, ImageUploader

  def deadline_cannot_save_in_the_past
    if deadline.present? && deadline <= DateTime.now - 1.day
      errors.add(:deadline, ": Cannot save in the past")
    end
  end

end
