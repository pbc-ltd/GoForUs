class Store < ActiveRecord::Base
  has_many :items
  has_many :orders, through: :items

  def address
    "#{address_1},\n #{address_2},\n #{county}\n, #{postcode}"
  end
end
