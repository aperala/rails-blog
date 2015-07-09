class AddOptionToPostsUserIdColumn < ActiveRecord::Migration
  def change
    change_column :posts, :user_id, :integer, null: false
  end
end
