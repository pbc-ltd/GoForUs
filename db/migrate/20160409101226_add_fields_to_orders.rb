class AddFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :mailboxer_conversation_id, :integer
    add_column :orders, :estimated_cost, :decimal
    add_column :orders, :final_cost, :decimal
    add_column :orders, :accepted, :boolean, default: false
    add_column :orders, :pickup_location_lat, :float
    add_column :orders, :pickup_location_lng, :float
    add_column :orders, :dropoff_location_lat, :float
    add_column :orders, :dropoff_location_lng, :float
    add_column :orders, :in_progress, :boolean, default: false
  end
end
