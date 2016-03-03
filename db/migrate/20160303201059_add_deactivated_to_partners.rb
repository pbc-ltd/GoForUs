class AddDeactivatedToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :deactivated, :boolean
  end
end
