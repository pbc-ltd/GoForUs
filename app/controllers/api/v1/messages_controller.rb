class Api::V1::MessagesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for Customer, fallback_to_devise: false
  acts_as_token_authentication_handler_for Partner, fallback_to_devise: false

  before_action :set_conversation
  before_action :set_message, only: [:mark_read]

  def index
    @messages = @conversationmessages

    if id = messages_params[:since_id]
      @messages = @messages.where('id > ?', id)
    end
  end

  def mark_as_read
    if @message
      @message.read = true
      if @message.save
        render json: { status: 'ok' }
      else
        render json: { status: 'failed', message: 'failed to save message' }
      end
    else
      render json: { status: 'failed', message: 'unable to find message' }
    end
  end

  private
  def set_conversation
    @conversation = user.conversations.find(messages_params[:conversation_id])
  end

  def set_message
    @receipt = @conversation.messages.find(message_params.fetch(:id))
  end

  def messages_params
    params.permit(:id, :conversation_id, :since_id)
  end
end
