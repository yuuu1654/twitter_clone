# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  def notification_email(notification)
    @notification = notification
    @user = notification.user
    if @notification.action_type == "followed_me"
      @action_user = notification.subject.follower
    else
      @action_user = notification.subject.user
    end
    @content = generate_content(@notification)
    mail to: 'to@example.org', subject: generate_subject(@notification)
  end

  private

  def generate_subject(notification)
    case notification.action_type
    when 'commented_to_own_tweet'
      "#{@action_user.name}さんがあなたのツイートにコメントしました。"
    when 'liked_to_own_tweet'
      "#{@action_user.name}さんがあなたのツイートをいいねしました。"
    when 'followed_me'
      "#{@action_user.name}さんにフォローされました。"
    when 'retweeted_to_own_tweet'
      "#{@action_user.name}さんがあなたのツイートをリツイートしました。"
    else
      '新しい通知があります。'
    end
  end

  def generate_content(notification)
    case notification.action_type
    when 'commented_to_own_tweet'
      "#{@action_user.name}さんがあなたのツイートにコメントしました。"
    when 'liked_to_own_tweet'
      "#{@action_user.name}さんがあなたのツイートをいいねしました。"
    when 'followed_me'
      "#{@action_user.name}さんにフォローされました。"
    when 'retweeted_to_own_tweet'
      "#{@action_user.name}さんがあなたのツイートをリツイートしました。"
    else
      '新しい通知があります。'
    end
  end
end
