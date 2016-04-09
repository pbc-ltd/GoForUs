json.array!(@conversations) do |conversation|
  json.id      conversation.id
  json.partner_id conversation.partner_id
  json.customer_id conversation.customer_id
end
