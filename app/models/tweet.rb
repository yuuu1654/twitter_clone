# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  has_one_attached :images
end
