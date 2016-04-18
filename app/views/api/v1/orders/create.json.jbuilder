if @saved
  json.(@order, :id, :accepted, :declined, :customer_id, :partner_id, :conversation_id, :dropoff_location_lat,
        :dropoff_location_lng, :pickup_location_lat, :pickup_location_lng, :final_cost,
       :estimated_cost, :in_progress, :pickup_address, :dropoff_address, :responded_to)
  json.conversation do
    json.(@conversation, :id, :partner_id, :customer_id)
  end
  json.message do
    json.id @message.id
    json.body @message.body
    json.is_me @message.sender_id == @user.id
    json.is_read @message.is_read?
  end
else

  json.error do
    json.order @order.errors.to_json
    json.conversation @converstion ? @conversation.errors.to_json : {}
  end
end
