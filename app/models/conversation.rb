class Conversation < ActiveRecord::Base
  belongs_to :partner
  belongs_to :customer
  belongs_to :job

  has_many :messages

  validates_presence_of :partner, :partner_id, :customer, :customer

  after_create :send_gcm_message

  def has_offer_attached?
    !!offer
  end

  def to_json
    {
      id: id,
      partner_id: partner_id,
      customer_id: customer_id
    }.to_json
  end

  private
  def send_gcm_message
    Rpush::Gcm::Notification.new(
      app: Rpush::Gcm::App.find_by_name('goforus_android'),
      registration_ids: [partner.gcm_device_token, customer.gcm_device_token], data: { type: 'New Conversation', conversation: self.to_json }
    ).save!
  end
end
