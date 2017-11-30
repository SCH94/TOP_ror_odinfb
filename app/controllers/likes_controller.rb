class LikesController < ApplicationController
  before_action :set_user_and_post_to_like
  
  def create
    @user.like!(@post)
    redirect_back(fallback_location: user_path(@post.user_id))
  end

  def destroy
    @user.unlike(@post)
    redirect_back(fallback_location: user_path(@post.user_id))
  end
  
  private
  
  def set_user_and_post_to_like
    @user = current_user
    @post = Post.find(params[:post_id])
  end
end
