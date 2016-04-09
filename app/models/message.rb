class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :partner
  belongs_to :customer

  validates_presence_of :conversation, :converastion_id

  def is_customer_message?
    !!customer
  end

  def is_partner_message?
    !is_customer_message
  end
end
