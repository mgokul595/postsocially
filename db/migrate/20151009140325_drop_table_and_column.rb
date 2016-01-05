class DropTableAndColumn < ActiveRecord::Migration
  def change
	remove_column :posts, :tag_id
	remove_column :tags, :post_id
	#drop_table :posts_tags_joins
	#drop_table :posts_tags
  end
end
