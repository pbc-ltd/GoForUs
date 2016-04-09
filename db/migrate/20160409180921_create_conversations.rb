class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :job_id
      t.integer :partner_id
      t.integer :customer_id

      t.timestamps null: false
    end

    add_index :conversations, :job_id
    add_index :conversations, :partner_id
    add_index :conversations, :customer_id
  end
end
