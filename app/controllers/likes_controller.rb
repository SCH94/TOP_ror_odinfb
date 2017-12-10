class LikesController < ApplicationController
  before_action :set_user_and_post
  
  def create
    @like.create
    redirect_back(fallback_location: user_path(@post.user_id))
  end

  def destroy
    @like.destroy
    redirect_back(fallback_location: user_path(@post.user_id))
  end
  
  private
  
  def set_user_and_post
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = UserLikeService.new(@user, @post)
  end
end
