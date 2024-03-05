# frozen_string_literal: true

class AddUniqueConstraintToRetweets < ActiveRecord::Migration[7.0]
  def change
    add_index :retweets, %i[user_id tweet_id], unique: true
  end
end
