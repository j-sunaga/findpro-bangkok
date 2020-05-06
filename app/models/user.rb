class User < ApplicationRecord
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
