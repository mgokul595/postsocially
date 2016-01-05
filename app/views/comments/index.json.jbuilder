json.array!(@comments) do |comment|
  json.extract! comment, :id, :Username, :comment, :post_id
  json.url comment_url(comment, format: :json)
end
