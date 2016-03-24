class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :partner_id
      t.integer :customer_id

      t.timestamps null: false
    end
    add_index :orders, :partner_id
    add_index :orders, :customer_id
  end
end
