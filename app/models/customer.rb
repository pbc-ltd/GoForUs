class Customer < User
  include Deactivateable::Model
  acts_as_token_authenticatable

  has_many :orders
  has_many :conversations
  has_many :messages, through: :conversations

end
