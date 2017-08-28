class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    if user_signed_in?
      @users = User.all
    else
      flash[:error] = 'You must sign in or sign up to continue'
      redirect_to new_user_session_path
    end
  end

  def show
    @user = current_user
    @friendships = @user.friendships
  end
end
