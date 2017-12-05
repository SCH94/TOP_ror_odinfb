class UserLike
  def initialize(user, post)
    @user = user
    @post = post
  end

  def create
    @user.likes.create!(post_id: @post.id)
  end

  def destroy
    @user.likes.delete(Like.find_by(post_id: @post.id))
  end
end