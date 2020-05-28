class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id
  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, scope: :recipient_id
  validate :conversation_cannot_start_same_user

  scope :user_conversation, lambda { |user_id|
    where('(conversations.sender_id = ?) OR (conversations.recipient_id =?)', user_id, user_id)
  }

  def target_user(current_user)
    if sender_id == current_user.id
      User.find(recipient_id)
    elsif recipient_id == current_user.id
      User.find(sender_id)
    end
  end

  def new_message
    messages.last
  end

  def conversation_cannot_start_same_user
    if sender_id == recipient_id
      errors.add(:expiration_date, ': can not start conversation with yourself')
    end
  end
end
