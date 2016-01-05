
object @topic
attributes :name

child :posts do
  attributes :id, :name, :message
  child :tags do
    attribute :name
  end
end