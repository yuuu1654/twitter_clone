# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :room
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  validates :sender_id, presence: true
  validates :recipient_id, presence: true
  validates :room_id, presence: true
  validates :body, presence: true
end
