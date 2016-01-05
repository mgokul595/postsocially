class User < ActiveRecord::Base

  has_many :posts

  has_many :ratings
  has_and_belongs_to_many :posts, join_table: 'user_posts_read_status'

  has_many :user_comment_ratings
  has_many :comments, through: :user_comment_ratings


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
