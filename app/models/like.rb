# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  has_one :notification, as: :subject, dependent: :destroy
  after_create_commit :create_notifications

  validates :user_id, presence: true
  validates :tweet_id, presence: true
  validates :user_id, uniqueness: { scope: :tweet_id }

  private

  def create_notifications
    Notification.create(subject: self, user: tweet.user, action_type: :liked_to_own_tweet)
    # NotificationMailer.notification_email(notification).deliver_now
  end
end
