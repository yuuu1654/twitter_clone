# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  after_create_commit :create_notifications
  has_one :notification, as: :resource, dependent: :destroy

  validates :content, presence: true

  private

  def create_notifications
    notification = Notification.create(subject: self, user: tweet.user, action_type: :commented_to_own_tweet)
    NotificationMailer.notification_email(notification).deliver_now
  end
end
