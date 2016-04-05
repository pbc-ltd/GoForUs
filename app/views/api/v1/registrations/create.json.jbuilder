if @customer.save
  json.(@customer, :id, :email, :mobile_number, :name, :authentication_token)
else
  json.errors @customer.errors
end
