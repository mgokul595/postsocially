class ChangeColumnNames < ActiveRecord::Migration
  def change
    rename_column :posts, :Name, :name
    rename_column :posts, :Email, :email
    rename_column :posts, :Message, :message

    rename_column :topics, :Name, :name

    rename_column :comments, :Username, :username
  end
end
