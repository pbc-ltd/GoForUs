class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.references :store, index: true, foreign_key: true
      t.float :price

      t.timestamps null: false
    end
  end
end
