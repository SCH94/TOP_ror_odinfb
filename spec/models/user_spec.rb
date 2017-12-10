require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:requested_friend) { create(:user) }
  let(:received_friend) { create(:user) }
  let(:awaiting_friend) { create(:user) }
  
  let(:awaiting_friendship) {
    create(
      :friendship, 
      user_id: user.id,
      friend_id: awaiting_friend.id
    )
  }
  let(:requested_friendship) {
    create(
      :friendship,
      user_id: user.id,
      friend_id: requested_friend.id,
      accepted: true
    )
  }
  let(:received_friendship) {
    create(
      :friendship,
      user_id: received_friend.id,
      friend_id: user.id,
      accepted: true
    )
  }

  before :each do
    requested_friendship
    received_friendship
    awaiting_friendship
  end

  describe ':all_except' do
    it "scopes to exclude a user" do
      users = User.all_except(user)
      expect(users).to_not include(user)
    end
  end
  
  describe '#accepted_friends' do
    it "returns accepted friends that a user requested" do
      expect(user.accepted_friends).to include(requested_friend)
    end

    it "returns accepted friends that a user received" do
      expect(user.accepted_friends).to include(received_friend)
    end

    it "does not return unaccepted friends" do
      expect(user.accepted_friends).to_not include(awaiting_friend)
    end
  end

  describe '#accepted_friendships' do
    it "returns accepted friendships that a user requested" do
      expect(user.accepted_friendships).to include(requested_friendship)
    end 

    it "returns accepted friendships that a user received" do
      expect(user.accepted_friendships).to include(received_friendship)
    end

    it "does not return unaccepted friendships" do
      expect(user.accepted_friendships).to_not include(awaiting_friendship)
    end
  end

  describe '#feed' do
    it "returns all posts by a user and accepted friends" do
      post1 = create(:post, user: user)
      post2 = create(:post, user: requested_friend)
      post3 = create(:post, user: received_friend)

      expect(user.feed).to include(post1, post2, post3)
    end

    it "does not return posts by unaccepted friends" do
      post1 = create(:post, user: user)
      post2 = create(:post, user: awaiting_friend)

      expect(user.feed).to_not include(post2)
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