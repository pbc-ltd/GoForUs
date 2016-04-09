class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :conversation_id
      t.integer :partner_id
      t.integer :customer_id
      t.integer :sender_id
      t.string :body

      t.timestamps null: false
    end

    add_index :messages, :partner_id
    add_index :messages, :customer_id
    add_index :messages, :conversation_id
  end
end
