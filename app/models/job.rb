class Job < ActiveRecord::Base
  belongs_to :partner
  belongs_to :customer
  belongs_to :order

  after_create :send_new_gcm_message
  after_update :send_updated_gcm_message

  def to_json
    to_hash.to_json
  end

  def to_hash
    {
      id: id,
      order_id: order_id,
      partner_id: partner_id,
      customer_id: customer_id,
      accepted: !!accepted,
      declined: !!declined,
      responded_to: !!responded_to
    }
  end

  private
  def send_new_gcm_message
    Rpush::Gcm::Notification.new(
      app: Rpush::Gcm::App.find_by_name('goforus_android'),
      registration_ids: [partner.gcm_device_token], data: { type: 'New Job', job: self.to_json }
    ).save!
  end

  def send_updated_gcm_message
    Rpush::Gcm::Notification.new(
      app: Rpush::Gcm::App.find_by_name('goforus_android'),
      registration_ids: [partner.gcm_device_token], data: { type: 'Updated Job', job: self.to_json }
    ).save!
  end
end
