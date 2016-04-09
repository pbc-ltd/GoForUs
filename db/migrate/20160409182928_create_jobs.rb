class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :order_id

      t.timestamps null: false
    end
  end
end
