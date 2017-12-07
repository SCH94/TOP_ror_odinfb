require 'rails_helper'

describe 'Friend management', type: :feature do
  before :example do
    @sender = create(:confirmed_user)
    @user = create(:confirmed_user)
    login_as(@user)
  end
  
  describe "sending a friend request" do
    before :each do
      visit authenticated_root_path
      click_link 'See all users'
      click_link 'Request'
    end

    it "displays a successful alert" do
      expect(page).to have_css("div.alert.alert-notice")
    end
    
    it "displays text next to a requested user indicating that a request has been sent" do
      expect(page).to have_content('Requested')
    end
  end

  describe "receiving a friend request" do
    before :each do
      @sender.friendships.create(friend_id: @user.id)
    end

    context "in the navbar" do
      it "displays a number badge" do
        visit authenticated_root_path
        expect(find('span.badge')).to have_content(1)
      end
    end

    context "in the user's profile" do
      before :each do
        visit user_path(@user)
      end

      it "displays the request sender's name" do
        expect(page).to have_content(@sender.name)
      end
  
      it "displays a button to accept the request" do
        expect(page).to have_css('a.btn.btn-success')
      end
  
      it "displays a button to decline the request" do
        expect(page).to have_css('a.btn.btn-danger')
      end
    end
  end

  describe "accepting a friend request" do
    context "for all requests" do
      before :each do
        @sender.friendships.create(friend_id: @user.id)
        visit user_path(@user)
        click_on 'Accept'
      end

      it "displays a successful alert" do
        expect(page).to have_css("div.alert.alert-notice")
      end

      it "moves the new friend to the Active Friends subsection" do
        within('#friends-active'){ expect(page).to have_content @sender.name }
      end

      it "displays a button to remove the friend" do
        within('#friends-active'){ expect(page).to have_css('a.btn.btn-danger') }
      end
    end

    context "for symmetrical friend requests" do
      it "removes the other user's pending request" do
        friendship_1 = @sender.friendships.create(friend_id: @user.id)
        friendship_2 = @user.friendships.create(friend_id: @sender.id)

        visit user_path(@user)
        click_on 'Accept'
        logout(@user)

        login_as(@sender)
        visit user_path(@sender)
        within('#friends-pending') { expect(page).to_not have_content(@user.name) }
      end
    end
  end

  describe "rejecting a friend request" do
    before :each do
      @sender.friendships.create(friend_id: @user.id)
      visit user_path(@user)
      click_on 'Decline'
    end

    it "displays a successful alert" do
      expect(page).to have_css("div.alert.alert-notice")
    end

    it "removes the requester's name from the user profile" do
      expect(page).to_not have_content(@sender.name)
    end
  end

  describe "deleting a friend" do
    before :each do
      create(:friendship, user_id: @sender.id, friend_id: @user.id)
      visit user_path(@user)
      click_on 'Remove'
    end

    it "removes the friend's name from the user profile" do
      expect(page).to_not have_content(@sender.name) 
    end

    it "displays a successful alert" do
      expect(page).to have_css("div.alert.alert-notice")
    end
  end
end