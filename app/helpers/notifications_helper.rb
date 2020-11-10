module NotificationsHelper
  def notification_form(notification)
    @comment = nil
    @visiter = notification.visiter
    case notification.action
    when 'follow'
      tag.a(@visiter.name, href: user_path(@visiter)) + 'があなたをフォローしました'
    when 'like'
      tag.a(@visiter.name, href: user_path(@visiter)) + 'が' + tag.a('あなたの投稿', href: post_path(notification.post_id)) + 'にいいね！しました'
    when 'comment' then
      @comment = Comment.find_by(id: notification.comment_id)&.text
      tag.a(@visiter.name, href: user_path(@visiter)) + 'が' + tag.a('あなたの投稿', href: post_path(notification.post_id)) + 'にコメントしました'
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
