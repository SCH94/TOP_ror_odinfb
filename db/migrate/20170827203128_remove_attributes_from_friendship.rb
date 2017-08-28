class RemoveAttributesFromFriendship < ActiveRecord::Migration[5.1]
  def change
    remove_column :friendships, :create
    remove_column :friendships, :destroy
  end
end
