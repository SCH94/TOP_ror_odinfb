class FriendshipsController < ApplicationController
  before_action :set_friendship_to_destroy, only: :destroy
  
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to users_path
    else
      flash[:error] = "Unable to add friend."
      redirect_to users_path
    end
  end

  def update
    @friendship = Friendship.find_by_user_id(params[:id])

    if @friendship.update(accepted: "true")
      redirect_to current_user, notice: "Successfully confirmed friend!"
    else
      redirect_to current_user, notice: "Sorry! Could not confirm friend!"
    end
  end

  def destroy
    @friendship.delete
    flash[:notice] = "You've unfriended someone."
    redirect_to session[:return_to]
  end

  private

  def set_friendship_to_destroy
    begin
      @friendship = current_user.friendships.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @friendship = current_user.received_friendships.find(params[:id])
    end
  end
end
