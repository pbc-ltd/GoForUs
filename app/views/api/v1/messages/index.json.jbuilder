json.array!(@conversations) do |conversation|
  json.id      conversation.id
  json.subject conversation.subject
  json.messages do
    json.array!(conversation.receipts_for(@user)) do |receipt|
      json.id receipt.id
      json.body receipt.message.body
      json.is_unread receipt.is_unread?
      json.is_me receipt.message.sender == @user
    end
  end
end
