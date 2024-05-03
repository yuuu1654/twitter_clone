# frozen_string_literal: true

class Follow < ApplicationRecord
  include Notificationable

  # Userクラスと関連付けされていることを明示
  belongs_to :follower, class_name: 'User', inverse_of: :active_relationships
  belongs_to :followed, class_name: 'User', inverse_of: :passive_relationships

  has_one :notification, as: :resource, dependent: :destroy

  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validates :follower_id, uniqueness: { scope: :followed_id }
end
