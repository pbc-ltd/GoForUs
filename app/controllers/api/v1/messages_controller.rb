class Api::V1::MessagesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for Customer, fallback_to_devise: false
  acts_as_token_authentication_handler_for Partner, fallback_to_devise: false

  before_action :set_conversation
  before_action :set_receipt, only: [:mark_read]

  def index
    @receipts = @conversation.receipts_for(user).includes(:message)
    # currently only using 1to1 relationship for a conversation
    @receiver = @conversation.original_message.recipients.select{|r| r.id != user.id}.last
    if id = messages_params[:since_id]
      @receipts = @receipts.where('mailboxer_receipts.id > ?', id)
    end
  end

  def mark_as_read
    if @receipt
      @receipt.mark_as_read
      render json: { status: 'ok' }
    else
      render json: { status: 'failed', message: 'unable to find message' }
    end
  end

  private
  def set_conversation
    @conversation = user.conversations.find(messages_params[:conversation_id])
  end

  def set_receipt
    @receipt = @conversation.receipts_for(@user).find(message_params.fetch(:id))
  end

  def messages_params
    params.permit(:id, :conversation_id, :since_id)
  end
end
