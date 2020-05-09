# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts, foreign_key: :recruiter_id
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_posts, through: :bookmarks, source: :post
  has_many :applications, dependent: :destroy
  has_many :application_posts, through: :applications, source: :post
  has_many :category_users, dependent: :destroy
  has_many :categories, through: :category_users, source: :category
  has_many :comments, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { in: 1..50 }
  validates :content, length: { in: 1..1000 }
  validates :applicant_or_recruiter, presence: true
  enum applicant_or_recruiter: { applicant: 0, recruiter: 1 }

  mount_uploader :profile_image, ImageUploader
end
