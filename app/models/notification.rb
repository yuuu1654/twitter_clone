# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :subject, polymorphic: true
  belongs_to :user

  enum action_type: { commented_to_own_tweet: 0, liked_to_own_tweet: 1, followed_me: 2, retweeted_to_own_tweet: 3 }
end
