json.array!(@conversations) do |conversation|
  json.id      conversation.id
  json.subject conversation.subject
end
