# frozen_string_literal: true

class Retweet < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  validates :user_id, presence: true
  validates :tweet_id, presence: true
  validates :user_id, uniqueness: { scope: :tweet_id }
end
