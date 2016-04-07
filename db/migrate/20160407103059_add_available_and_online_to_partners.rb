class AddAvailableAndOnlineToPartners < ActiveRecord::Migration
  def change
    add_column :users, :available, :boolean, default: false
    add_column :users, :online, :boolean, default: false
    add_column :users, :rating, :integer, default: 5
  end
end
