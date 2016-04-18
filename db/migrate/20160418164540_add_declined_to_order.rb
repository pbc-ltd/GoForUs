class AddDeclinedToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :declined, :boolean
  end
end
