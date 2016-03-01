class Store < ActiveRecord::Base
  has_many :items
  has_many :orders, through: :items
end
