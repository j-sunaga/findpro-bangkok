class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_same_user, only: %i[create]

  def index
    @conversations = Conversation.all
  end

  def create
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
      redirect_to conversation_messages_path(@conversation)
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  def check_same_user
    if params[:sender_id] == params[:recipient_id]
      redirect_back(fallback_location: root_path, notice: 'Can not Start conversation same user')
    end
  end
end
