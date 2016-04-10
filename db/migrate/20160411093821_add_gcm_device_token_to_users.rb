class AddGcmDeviceTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gcm_device_token, :string
  end
end
