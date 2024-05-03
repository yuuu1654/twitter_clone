# frozen_string_literal: true

class Comment < ApplicationRecord
  include Notificationable

  belongs_to :user
  belongs_to :tweet
  has_one :notification, as: :resource, dependent: :destroy

  validates :content, presence: true
end
