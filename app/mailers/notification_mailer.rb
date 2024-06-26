# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  def notification_email(notification)
    @notification = notification
    @user = notification.user
    @action_user = if notification.follow?
                     notification.resource.follower
                   else
                     notification.resource.user
                   end
    @content = generate_content(@notification)
    mail to: 'to@example.org', subject: generate_content(@notification)
  end

  private

  def generate_content(notification)
    case notification.action_type.to_sym
    when :comment
      "#{@action_user.name}さんがあなたのツイートにコメントしました。"
    when :like
      "#{@action_user.name}さんがあなたのツイートをいいねしました。"
    when :follow
      "#{@action_user.name}さんにフォローされました。"
    when :retweet
      "#{@action_user.name}さんがあなたのツイートをリツイートしました。"
    else
      '新しい通知があります。'
    end
  end
end
