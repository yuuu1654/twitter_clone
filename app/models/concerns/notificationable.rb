# frozen_string_literal: true

module Notificationable
  extend ActiveSupport::Concern

  included do
    after_create_commit :create_notification
  end

  private

  def create_notification
    # notification = if instance_of?(::Follow)
    #                  Notification.create(resource: self, user: followed, action_type: self.class.name.downcase)
    #                else
    #                  Notification.create(resource: self, user: tweet.user, action_type: self.class.name.downcase)
    #                end

    user = instance_of?(::Follow) ? followed : tweet.user
    notification = user.notifications.create(resource: self, action_type: self.class.name.downcase)

    # ▼本番でメール送信できないのでコメントアウト (Mailgun止めている)
    NotificationMailer.notification_email(notification).deliver_now
  end
end
