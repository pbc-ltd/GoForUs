class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :registration, unique: true
      t.string :make
      t.string :model
      t.string :type
      t.boolean :online_with, default: false
      t.integer :partner_id

      t.timestamps null: false
    end
  end
end
