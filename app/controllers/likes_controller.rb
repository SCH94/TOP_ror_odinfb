class LikesController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @user.like!(@post)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @user = current_user
    @like = @user.likes.find_by_post_id(params[:post_id])
    @post = Post.find(params[:post_id])
    @like.destroy!
    redirect_back(fallback_location: root_path)
  end
end
