json.array!(@ratings) do |rating|
  json.extract! rating, :id, :star, :post_id
  json.url rating_url(rating, format: :json)
end
