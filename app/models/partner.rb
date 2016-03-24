class Partner < User
  include Deactivateable::Model
  acts_as_token_authenticatable

  has_many :orders
end
