# frozen_string_literal: true

class User < ApplicationRecord
  has_many :recruiting_posts, class_name: 'Post', foreign_key: :recruiter_id
  has_many :selected_posts, class_name: 'Post', foreign_key: :selected_user_id
  has_many :senders, class_name: 'Conversation', foreign_key: :sender_id
  has_many :recipients, class_name: 'Conversation', foreign_key: :recipient_id
  has_many :messages, dependent: :destroy
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
         :recoverable, :rememberable, :validatable, :trackable

  validates :name, presence: true, length: { in: 1..50 }
  validates :content, length: { in: 1..1000 }
  validates :applicant_or_recruiter, presence: true
  enum applicant_or_recruiter: { applicant: 0, recruiter: 1 }

  mount_uploader :profile_image, ImageUploader

  def recruiter?
    if self.applicant_or_recruiter == 'recruiter'
      true
    else
      false
    end
  end

  def applicant?
    if self.applicant_or_recruiter == 'applicant'
      true
    else
      false
    end
  end

end
