class CreateUserCommentRatings < ActiveRecord::Migration
  def change
    create_table :user_comment_ratings do |t|
      t.integer :star
      t.integer :user_id
      t.integer :comment_id

      t.timestamps null: false
    end
  end
end
