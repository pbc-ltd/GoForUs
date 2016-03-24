class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address_1
      t.string :address_2
      t.string :county
      t.string :postcode

      t.float :lng
      t.float :lat

      t.timestamps null: false
    end

    add_earthdistance_index :stores
  end
end
