# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  has_one :notification, as: :subject, dependent: :destroy
  after_create_commit :create_notifications

  validates :content, presence: true

  private

  def create_notifications
    notification = Notification.create(subject: self, user: tweet.user, action_type: :commented_to_own_tweet)
    NotificationMailer.notification_email(notification).deliver_now
  end
end
