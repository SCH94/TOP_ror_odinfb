class EditIndicesOnFriendships < ActiveRecord::Migration[5.1]
  def change
    remove_index :friendships, column: :user_id
    remove_index :friendships, column: :friend_id
    
    add_index :friendships, [:user_id, :friend_id]
  end
end
