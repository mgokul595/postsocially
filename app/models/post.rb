class Post < ActiveRecord::Base
	belongs_to :user
  belongs_to :topic
	has_many :comments
	has_and_belongs_to_many :tags
  has_many :ratings

  scope :created_after, ->(from) {where("posts.created_at > ?", from)}
  scope :created_before, ->(to) {where("posts.created_at < ?", to)}

  validates_presence_of :name, :presence => true, message: " is empty"
  validates_length_of :name, maximum: 20, message: " length is too long"
  validates_presence_of :message, message: " is empty"
  has_attached_file :image
  #validates_attachment_presence :image, :presence => true
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
  validates_attachment_size :image, :in => 0..10.kilobytes

end
