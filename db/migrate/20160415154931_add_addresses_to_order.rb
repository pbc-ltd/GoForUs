class AddAddressesToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :pickup_address, :string
    add_column :orders, :dropoff_address, :string
  end
end
