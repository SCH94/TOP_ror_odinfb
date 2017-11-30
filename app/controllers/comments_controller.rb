class CommentsController < ApplicationController
  before_action :set_post_to_comment_on, only: :create

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.build(comment_params)
    if @comment.save
      redirect_to session[:return_to]
    else
      flash.now[:danger] = "Can't submit a blank comment!"
      render :new
    end
  end

  private
  
  def set_post_to_comment_on
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
end
