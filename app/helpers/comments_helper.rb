module CommentsHelper
  def comment_user_avatar(comment)
    if comment.avatar.attached?
      comment.avatar
    else
      '/avatar/avatar.png'
    end
  end
end
