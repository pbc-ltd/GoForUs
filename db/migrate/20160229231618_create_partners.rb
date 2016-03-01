class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :name
      t.string :mobile_number

      t.timestamps null: false
    end
  end
end
