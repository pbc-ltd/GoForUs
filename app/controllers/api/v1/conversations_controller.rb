class Api::V1::ConversationsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for Customer, fallback_to_devise: false
  acts_as_token_authentication_handler_for Partner, fallback_to_devise: false

  def all
    @conversations = user.mailbox.conversations
    render :index
  end

  def inbox
    @conversations = user.mailbox.inbox
    if id = index_params[:since_id]
      @conversations = @conversations.where('mailboxer_conversations.id > ?', id)
    end
    render :index
  end

  def sentbox
    @conversations = user.mailbox.sentbox
    render :index
  end

  def trash
    @conversations = user.mailbox.trash
    render :index
  end

  def reply
    convo = Mailboxer::Conversation.find(reply_params.fetch(:conversation_id))
    if convo
      user.reply_to_conversation(convo, reply_params.fetch(:message))
      render json: { status: 'ok' }
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
