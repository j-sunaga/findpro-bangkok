class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body
  validates :body, length: { in: 1..255 }
end
