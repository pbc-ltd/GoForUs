class AddRepondedToToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :responded_to, :boolean
  end
end
