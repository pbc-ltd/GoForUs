class Order < ActiveRecord::Base
  belongs_to :partner
  belongs_to :customer
  belongs_to :conversation

  has_many :order_items
  has_many :items, through: :order_items


  after_create :send_gcm_message

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
      final_cost: final_cost,
      estimated_cost: estimated_cost,
      in_progress: in_progress,
      conversation_id: conversation_id
    }
  end


  private
  def send_gcm_message
    Rpush::Gcm::Notification.new(
      app: Rpush::Gcm::App.find_by_name('goforus_android'),
      registration_ids: [partner.gcm_device_token], data: { type: 'New Order', order: self.to_json }
    ).save!
  end
end
