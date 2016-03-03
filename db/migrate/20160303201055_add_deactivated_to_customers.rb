class AddDeactivatedToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :deactivated, :boolean
  end
end
