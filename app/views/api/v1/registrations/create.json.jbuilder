if @customer.save
  json.(@customer, :id, :email, :mobile_number, :name, :authentication_token, :user_type)
else
  json.errors @customer.errors
end
