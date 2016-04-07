class Partner < User
  include Deactivateable::Model
  acts_as_token_authenticatable

  has_many :orders
  has_many :vehicles

  validates_numericality_of :rating, greater_than_or_equal_to: 0, less_than_or_equal_to: 5
end
