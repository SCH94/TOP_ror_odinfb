require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:requested_friend) { create(:user) }
  let(:requesting_friend) { create(:user) }
  let(:post) { create(:post) }

  let(:requested_friendship) {
    create(
      :friendship,
      user_id: user.id,
      friend_id: requested_friend.id
    )
  }

  let(:requesting_friendship) {
    create(
      :friendship,
      user_id: requesting_friend.id,
      friend_id: user.id
    )
  }

  before :each do
    requested_friendship
    requesting_friendship
  end

  describe ':all_except' do
    it "scopes to exclude a user" do
      users = User.all_except(user)
      expect(users).to_not include(user)
    end
  end
  
  describe '#friends' do
    it "returns user's friends requested and accepted" do
      expect(user.friends).to include(requested_friend)
    end

    it "returns user's friends requesting and accepted" do
      expect(user.friends).to include(requesting_friend)
    end
  end

  describe '#all_friendships' do
    it "returns friendships requested and accepted" do
      expect(user.all_friendships).to include(requested_friendship)
    end 

    it "returns friendships requesting and accepted" do
      expect(user.all_friendships).to include(requesting_friendship)
    end
  end

  describe '#feed' do
    it "returns all posts by user and friends" do
      post1 = create(:post, user: user)
      post2 = create(:post, user: requested_friend)
      post3 = create(:post, user: requesting_friend)

      expect(user.feed).to match_array([post1, post2, post3])
    end
  end

  describe '#from_omniauth()' do
    it "returns a user" do
      omniauth = { 
        provider: 'facebook',
        uid: '12345',
        info: {
          email: user.email,
          password: Devise.friendly_token[0, 20],
          name: user.name                              
        }
      }
      expect(User.from_omniauth(omniauth[:info])).to eq(user)
    end
  end
end