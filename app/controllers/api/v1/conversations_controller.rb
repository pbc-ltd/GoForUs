class Api::V1::ConversationsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for Customer, fallback_to_devise: false
  acts_as_token_authentication_handler_for Partner, fallback_to_devise: false

  after_action :params_applicator, only: [:inbox, :sentbox, :trash]

  def all
    @conversations = user.mailbox.conversations.map
    render :index
  end

  def inbox
    @conversations = user.mailbox.inbox
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
    user.reply_to_conversation(reply_params.fetch(:conversation_id), reply_params.fetch(:message))
    render json: { status: 'ok' }
  end

  private
  def reply_params
    params.permit(:conversation_id, :message)
  end

  def messages_params
    params.permit()
  end
end
