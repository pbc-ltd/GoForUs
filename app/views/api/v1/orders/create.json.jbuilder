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
    json.is_read @message.is_read?
    json.sender_id @message.sender_id
    json.partner_id @message.partner_id
    json.customer_id @message.customer_id
    json.conversation_id @message.conversation_id
  end
else

  json.error do
    json.order @order.errors.to_json
    json.conversation @converstion ? @conversation.errors.to_json : {}
  end
end
