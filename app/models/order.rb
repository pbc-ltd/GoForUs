class Order < ActiveRecord::Base
  belongs_to :partner
  belongs_to :customer

  has_many :order_items
  has_many :items, through: :order_items
end
