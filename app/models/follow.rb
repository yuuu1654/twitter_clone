# frozen_string_literal: true

class Follow < ApplicationRecord
  # Userクラスと関連付けされていることを明示
  belongs_to :follower, class_name: 'User', inverse_of: :active_relationships
  belongs_to :followed, class_name: 'User', inverse_of: :passive_relationships

  has_one :notification, as: :subject, dependent: :destroy
  after_create_commit :create_notifications

  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validates :follower_id, uniqueness: { scope: :followed_id }

  private

  def create_notifications
    notification = Notification.create(subject: self, user: followed, action_type: :followed_me)
    NotificationMailer.notification_email(notification).deliver_now
  end
end
