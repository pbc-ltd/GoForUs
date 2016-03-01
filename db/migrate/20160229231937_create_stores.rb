class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :lng
      t.string :lat
      t.string :address_1
      t.string :address_2
      t.string :county
      t.string :postcode

      t.timestamps null: false
    end
  end
end
