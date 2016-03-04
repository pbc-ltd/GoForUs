class AddDeactivatedToStores < ActiveRecord::Migration
  def change
    add_column :stores, :deactivated, :boolean
  end
end
