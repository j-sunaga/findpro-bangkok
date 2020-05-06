class Post < ApplicationRecord
  class << self; undef :open; end

  belongs_to :recruiter, class_name: 'User', foreign_key: :recruiter_id
  validates :title, presence: true, length: { in: 1..50 }
  validates :detail, length: { in: 1..1000 }
  validates :status, presence: true

  enum status: { open: 0, closed: 1 }
  mount_uploader :post_image, ImageUploader
end
