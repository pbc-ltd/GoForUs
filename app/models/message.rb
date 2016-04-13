class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :partner
  belongs_to :customer

  validates_presence_of :conversation, :conversation_id

  after_create :send_notification

  def is_customer_message?
    !!customer
  end

  def is_partner_message?
    !is_customer_message
  end

  def to_json
    {
      id: id,
      body: body,
      is_read: is_read?,
      sender_id: sender_id,
      partner_id: partner_id,
      customer_id: customer_id,
      conversation_id: conversation_id
    }.to_json
  end

  private
  def send_notification
    gcm_device_token = is_customer_message? ? conversation.partner.gcm_device_token : conversation.customer.gcm_device_token
    Rpush::Gcm::Notification.new(
      app: Rpush::Gcm::App.find_by_name('goforus_android'),
      registration_ids: [gcm_device_token], data: { type: 'New Message', message: self.to_json }
    ).save!

  end
end
