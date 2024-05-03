# frozen_string_literal: true

module Notificationable
  extend ActiveSupport::Concern

  included do
    after_create_commit :create_notification
  end

  private

  def create_notification
    notification = if instance_of?(::Follow)
                     Notification.create(resource: self, user: followed, action_type: self.class.name.downcase)
                   else
                     Notification.create(resource: self, user: tweet.user, action_type: self.class.name.downcase)
                   end

    logger.debug "hogehoge: #{notification.action_type}"
    NotificationMailer.notification_email(notification).deliver_now
  end
end
