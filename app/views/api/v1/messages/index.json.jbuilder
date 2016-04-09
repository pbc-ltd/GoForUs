json.array!(@messages) do |message|
  json.id message.id
  json.body message.body
  json.is_me (message.sender_id == @user.id)
  json.is_read message.is_read?
end
