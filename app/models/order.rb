class Order < ActiveRecord::Base
  belongs_to :partner
  belongs_to :customer
  belongs_to :mailboxer_conversation, class_name: 'Mailboxer::Conversation'

  has_many :order_items
  has_many :items, through: :order_items

  def conversation
    mailboxer_conversation
  end
end
