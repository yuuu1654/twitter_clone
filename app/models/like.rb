# frozen_string_literal: true

class Like < ApplicationRecord
  include Notificationable

  belongs_to :user
  belongs_to :tweet
  has_one :notification, as: :resource, dependent: :destroy

  validates :user_id, presence: true
  validates :tweet_id, presence: true
  validates :user_id, uniqueness: { scope: :tweet_id }
end
