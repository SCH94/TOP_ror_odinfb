require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let (:user) { create(:user) }
  let (:friend1) { create(:user) }
  let (:friend2) { create(:user) }
  let (:friendship1) {
    create(
      :friendship,
      user_id: user.id,
      friend_id: friend1.id
    )    
  }
  let (:friendship2) {
    create(
      :friendship,
      user_id: friend2.id,
      friend_id: user.id
    )    
  }

  describe '#return_friend_id()' do
    it "returns the friend's id when user initiates" do
      expect(
        friendship1.return_friend_id(user.id)
      ).to eq(friend1.id)
    end

    it "returns the friend's id when friend initiates" do
      expect(
        friendship2.return_friend_id(user.id)        
      ).to eq(friend2.id)
    end
  end
end
