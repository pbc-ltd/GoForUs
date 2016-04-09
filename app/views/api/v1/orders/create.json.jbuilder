if @saved
  json.(@order, :id, :accepted, :customer_id, :partner_id, :dropoff_location_lat,
        :dropoff_location_lng, :pickup_location_lat, :pickup_location_lng, :final_cost,
       :estimated_cost, :in_progress)
  json.conversation do
    json.(@conversation, :id, :subject)
  end
  json.message do
    json.id @receipt.id
    json.body @receipt.message.body
    json.is_me @receipt.message.sender == @user
    json.is_read_by_sender @receipt.message.is_read?(@receipt.message.sender)
    json.is_read_by_receiver @receipt.message.is_read?(@receipt.receiver)
  end
else

  json.error do
    json.order @order.errors.to_json
    json.receipt @receipt.errors.to_json
    json.conversation @converstion ? @conversation.errors.to_json : {}
  end
end
