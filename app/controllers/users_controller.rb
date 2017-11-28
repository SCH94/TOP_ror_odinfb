class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    session[:return_to] = request.fullpath
    
    if user_signed_in?
      @users = User.all_except(current_user)
    else
      flash[:error] = 'You must sign in or sign up to continue'
      redirect_to new_user_session_path
    end
  end

  def show
    @user = User.includes(:posts).find(params[:id])
    @pending_friendships = @user.received_friendships.where(accepted: false)
    session[:return_to] = request.fullpath
  end
end
