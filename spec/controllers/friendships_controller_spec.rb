require 'rails_helper'

describe FriendshipsController do
  let (:user)   { create(:confirmed_user) }
  let (:friend) { create(:confirmed_user) }
  let (:third)  { create(:confirmed_user) }
  let (:friendship) { create(:friendship, user_id: user.id, friend_id: friend.id) }
  
  describe 'POST #create' do
    context 'when successful' do
      it 'creates a new friendship' do
        sign_in user
        expect{ 
          post :create, params: { friend_id: friend.id }
        }.to change{ Friendship.count }.by 1
      end
    end

    context 'when unsuccessful' do
      it 'does not create a new friendship' do
        sign_in user
        expect{
          post :create, params: { friend_id: nil }          
        }.to_not change{ Friendship.count }
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      friendship
      session[:return_to] = request.fullpath
    end

    context 'when signed in as the user' do
      it 'deletes a friend/friendship' do
        sign_in user
        expect{
          delete :destroy, params: { id: friendship.id }     
        }.to change{ Friendship.count }.by -1 
      end
    end

    context 'when signed in as the friend' do
      it 'deletes a friend/friendship' do
        sign_in friend
        expect{
          delete :destroy, params: { id: friendship.id }          
        }.to change{ Friendship.count }.by -1
      end
    end

    context 'when signed in as a third-party' do
      it 'does not delete a friend/friendship' do
        sign_in third
        expect{
          delete :destroy, params: { id: friendship.id }          
        }.to_not change{ Friendship.count }
      end
    end
  end
end