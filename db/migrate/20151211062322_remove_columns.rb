class RemoveColumns < ActiveRecord::Migration
  def change
    remove_column :posts, :email
    remove_column :comments, :username
  end
end
