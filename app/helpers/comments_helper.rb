module CommentsHelper
  def comment_user_avatar(comment)
    if comment.profile.avatar.attached?
      image_tag(comment.profile.avatar, class: 'rounded-circle com-ava')
    else
      image_tag('/avatar/avatar.png', class: 'rounded-circle com-ava')
    end
  end
end
