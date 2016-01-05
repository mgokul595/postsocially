class JoinUserAndPosts < ActiveRecord::Migration
  def change
    create_table 'user_posts_read_status' do |t|
      t.integer :user_id
      t.integer :post_id
    end
  end
end
