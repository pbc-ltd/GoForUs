json.array!(@receipts) do |receipt|
  json.id receipt.id
  json.body receipt.message.body
  json.is_me receipt.message.sender == @user
  json.is_read_by_sender receipt.message.is_read?(receipt.message.sender)
  json.is_read_by_receiver receipt.message.is_read?(@receiver)
end
