class Order < ActiveRecord::Base
  belongs_to :partner
  belongs_to :customer
  belongs_to :conversation

  has_many :order_items
  has_many :items, through: :order_items
  has_many :jobs

  after_create :send_new_gcm_message
  after_update :send_updated_gcm_message

  def to_json
    to_hash.to_json
  end

  def to_hash
    {
      id: id,
      accepted: accepted,
      partner_id: partner_id,
      customer_id: customer_id,
      dropoff_location_lat: dropoff_location_lat,
      dropoff_location_lng: dropoff_location_lng,
      pickup_location_lat: pickup_location_lat,
      pickup_location_lng: pickup_location_lng,
      pickup_address: pickup_address,
      dropoff_address: dropoff_address,
      final_cost: final_cost ? final_cost : 0,
      estimated_cost: estimated_cost ? estimated_cost : 0,
      in_progress: !!in_progress,
      responded_to: !!responded_to,
      conversation_id: conversation_id
    }
  end

  def job
    jobs.last
  end


  private
  def send_new_gcm_message
    Rpush::Gcm::Notification.new(
      app: Rpush::Gcm::App.find_by_name('goforus_android'),
      registration_ids: [partner.gcm_device_token], data: { type: 'New Order', order: self.to_json }
    ).save!
  end

  def send_updated_gcm_message
    if job && job.responded_to
      if accepted
        Rpush::Gcm::Notification.new(
          app: Rpush::Gcm::App.find_by_name('goforus_android'),
          registration_ids: [partner.gcm_device_token, customer.gcm_device_token], data: { type: 'Accepted Order', order: self.to_json }
        ).save!
      elsif declined
        Rpush::Gcm::Notification.new(
          app: Rpush::Gcm::App.find_by_name('goforus_android'),
          registration_ids: [partner.gcm_device_token, customer.gcm_device_token], data: { type: 'Declined Order', order: self.to_json }
        ).save!
      end
    else
        Rpush::Gcm::Notification.new(
          app: Rpush::Gcm::App.find_by_name('goforus_android'),
          registration_ids: [partner.gcm_device_token, customer.gcm_device_token], data: { type: 'Updated Order', order: self.to_json }
        ).save!
    end
  end
end
