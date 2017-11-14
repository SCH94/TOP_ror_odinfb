module PostsHelper
  def text_for_comment_toggle(post)
    if post.comments.nil?
      "No comments to view"
    else
      "See #{pluralize(post.comments.count, 'comment')}"
    end
  end
end