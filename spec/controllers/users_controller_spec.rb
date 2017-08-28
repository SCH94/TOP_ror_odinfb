require 'rails_helper'

describe UsersController do
  describe 'GET #index' do
    context 'while logged in' do
      it 'renders the :index template' do
        sign_in create(:user)
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context 'while logged out' do
      it 'renders the sign-in template' do
        get :index
        expect(response).to redirect_to new_user_session_url
      end

      it 'flashes an [:error]' do
        get :index
        expect(flash[:error]).to be_present
      end
    end
  end

  describe 'GET #show' do
    let (:user) { create(:user) }
    context 'while logged in' do
      it 'renders the :show template' do
        sign_in user
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:success)
      end
    end

    context 'while logged out' do
      it 'renders the sign-in template' do
        get :show, params: { id: user.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
  end
end