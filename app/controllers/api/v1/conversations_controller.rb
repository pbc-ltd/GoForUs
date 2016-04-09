class Api::V1::ConversationsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for Customer, fallback_to_devise: false
  acts_as_token_authentication_handler_for Partner, fallback_to_devise: false

  def inbox
    @conversations = user.conversations
    if id = index_params[:since_id]
      @conversations = @conversations.where('conversations.id > ?', id)
    end
    render :index
  end

  def reply
    conversation = user.conversations.find(reply_params.fetch(:conversation_id))
    if conversation
      message = nil
      if user.user_type == 'Customer'
        message = conversation.messages.new(sender_id: user.id, customer_id: user.id, body: reply_params.fetch(:message))
      elsif user.user_type == 'Partner'
        message = conversation.messages.new(sender_id: user.id, partner_id: user.id, body: reply_params.fetch(:message))
      end

      if message.save
        render json: { status: 'ok' }
      else
        render json: { status: 'failed', message: 'unable to save message' }
      end
    else
      render json: { status: 'failed', message: 'unable to find conversation with id given' }
    end
  end

  private
  def reply_params
    params.permit(:conversation_id, :message)
  end

  def index_params
    params.permit(:since_id)
  end
end
