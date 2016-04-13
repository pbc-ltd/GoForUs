json.array!(@messages) do |message|
  json.id message.id
  json.body message.body
  json.is_read message.is_read?
  json.sender_id message.sender_id
  json.partner_id message.partner_id
  json.customer_id message.customer_id
  json.conversation_id message.conversation_id
end
