require 'rails_helper'

describe FriendshipsController do
  describe 'GET #create' do
    let (:user) { create(:confirmed_user) }
    let (:friend) { create(:confirmed_user) }

    context 'when successful' do
      it 'creates a new friendship' do
        sign_in user
        expect{ 
          get :create, params: { friend_id: friend.id }
        }.to change{ Friendship.count }.by 1
      end
      
      it 'flashes a [:notice]' do
        sign_in user
        get :create, params: { friend_id: friend.id }
        expect(flash[:notice]).to be_present
      end
    end

    context 'when unsuccessful' do
      it 'flashes an [:error]' do
        sign_in user
        get :create, params: { friend_id: nil }
        expect(flash[:error]).to be_present
      end

      it 'redirects to root' do
        sign_in user
        get :create, params: { friends_id: nil }
        expect(response).to redirect_to users_path
      end
    end
  end
end