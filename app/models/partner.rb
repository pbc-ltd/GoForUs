class Partner < User
  include Deactivateable::Model
  acts_as_token_authenticatable

  has_many :jobs
  has_many :orders
  has_many :vehicles

  has_many :conversations
  has_many :messages, through: :conversations

  validates_numericality_of :rating, greater_than_or_equal_to: 0, less_than_or_equal_to: 5

  after_update :send_updated_gcm_message

  def to_json
    to_hash.json
  end

  def to_hash
    {
      id: id,
      email: email,
      name: name,
      authentication_token: authentication_token,
      user_type: user_type,
      available: available,
      online: online
    }
  end

  private
  def send_updated_gcm_message
    Rpush::Gcm::Notification.new(
      app: Rpush::Gcm::App.find_by_name('goforus_android'),
      registration_ids: [gcm_device_token], data: { type: 'Updated Account', account: self.to_json }
    ).save!
  end
end
