class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = current_user.feed.includes(:likes, comments: [:user])
    session[:return_to] = request.fullpath
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'Post was successfully created.'
      redirect_to session[:return_to]
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
