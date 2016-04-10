if @customer.save
  json.(@customer, :id, :email, :mobile_number, :name, :authentication_token, :user_type, :available, :online)
else
  json.errors @customer.errors
end
