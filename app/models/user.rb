# frozen_string_literal: true

class User < ApplicationRecord
  has_many :recruiting_posts, class_name: 'Post', foreign_key: :recruiter_id, dependent: :destroy
  has_many :selected_posts, class_name: 'Post', foreign_key: :selected_user_id
  has_many :senders, class_name: 'Conversation', foreign_key: :sender_id, dependent: :destroy
  has_many :recipients, class_name: 'Conversation', foreign_key: :recipient_id, dependent: :destroy
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

  scope :applicants, -> { where(applicant_or_recruiter: 'applicant') }

  def recruiter?
    applicant_or_recruiter == 'recruiter'
  end

  def applicant?
    applicant_or_recruiter == 'applicant'
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  scope :keyword_like, lambda { |query|
                         where('users.name LIKE ?', "%#{query}%").or(where('content LIKE ?', "%#{query}%"))
                       }

  scope :category_users, ->(category) { joins(:categories).merge(Category.select_category(category)) }

  def self.search(keyword, category, page_number)
    if category.present?
      User.page(page_number).keyword_like(keyword).category_users(category)
    else
      User.page(page_number).keyword_like(keyword)
    end
  end

  def self.guest
    if find_by(name: 'test_user')
      user = find_by(name: 'test_user')
    else
      create(name: 'test_user', email: 'test_user@example.com', content: 'test', admin: true) do |user|
        user.password = '123456'
      end
    end
  end
end
