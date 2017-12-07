class FriendshipsController < ApplicationController
  before_action :set_friendship_request, only: [:update, :decline]
  after_action  :destroy_symmetrical_friendship, if: :symmetrical_friendship?, only: :update
  before_action :set_friendship_to_destroy, only: :destroy
  
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    
    if @friendship.save
      flash[:notice] = "Sent a request."
      redirect_to users_path
    else
      flash[:error] = "Unable to add friend."
      redirect_to users_path
    end
  end

  def update
    if @friendship.update(accepted: "true")
      flash[:notice] = "Successfully confirmed friend!"
      redirect_to current_user
    else
      flash[:error] = "Sorry! Could not confirm friend!"
      redirect_to current_user
    end
  end

  def decline
    if @friendship.destroy
      flash[:notice] = "Successfully declined request!"
      redirect_to current_user
    else
      flash[:error] = "Sorry! Something went wrong!"
      redirect_to current_user
    end
  end

  def destroy
    if @friendship.destroy
      flash[:notice] = "You've unfriended someone."
      redirect_to session[:return_to]
    else
      flash[:error] = "Sorry! Something went wrong!"
      redirect_to current_user
    end
  end

  private

  def set_friendship_request
    @friendship = Friendship.find_by(friend_id: params[:friend_id], user_id: params[:id])
  end

  def symmetrical_friendship?
    @symmetrical_friendship = Friendship.find_by(friend_id: params[:id], user_id: params[:friend_id])
  end

  def destroy_symmetrical_friendship
    @symmetrical_friendship.destroy
  end

  def set_friendship_to_destroy
    begin
      @friendship = current_user.friendships.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @friendship = current_user.received_friendships.find(params[:id])
    end
  end
end
