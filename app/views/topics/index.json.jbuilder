json.array!(@topics) do |topic|
  json.extract! topic, :id, :Name
  json.url topic_url(topic, format: :json)
end
