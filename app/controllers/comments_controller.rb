class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @poster = User.find(@post.user_id)

    if @comment.save
      redirect_to user_path(@poster)
    else
      flash.now[:danger] = "There was a mistake"
      render :new
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body).merge(user_id: current_user.id)
    end
end