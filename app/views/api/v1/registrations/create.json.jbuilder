if @customer.save
  json.(@customer, :id, :email, :mobile_number, :name, :authentication_token)
else
  json.(@customer, :id, :email, :mobile_number, :name)
  json.errors @customer.errors
end
