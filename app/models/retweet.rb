# frozen_string_literal: true

class Retweet < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  after_create_commit :create_notifications
  has_one :notification, as: :resource, dependent: :destroy

  validates :user_id, presence: true
  validates :tweet_id, presence: true
  validates :user_id, uniqueness: { scope: :tweet_id }

  private

  def create_notifications
    notification = Notification.create(subject: self, user: tweet.user, action_type: :retweeted_to_own_tweet)
    NotificationMailer.notification_email(notification).deliver_now
  end
end
