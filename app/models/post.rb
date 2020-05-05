class Post < ApplicationRecord
  validates :title, presence: true, length: { in: 1..50 }
  validates :detail, length: { in: 1..1000 }
  validates :status, presence: true

  enum status: { open: 0, closed: 1 }
  mount_uploader :post_image, PostImageUploader
end
