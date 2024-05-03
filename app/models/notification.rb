# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :resource, polymorphic: true
  belongs_to :user

  enum action_type: { comment: 0, like: 1, follow: 2, retweet: 3 }
end
