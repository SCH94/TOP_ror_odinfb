class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def return_friend_id(current_user_id)
    current_user_id == self.user_id ? self.friend_id : self.user_id
  end
end