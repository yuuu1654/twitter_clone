# frozen_string_literal: true

class AddUniqueConstraintToBookmarks < ActiveRecord::Migration[7.0]
  def change
    add_index :bookmarks, %i[user_id tweet_id], unique: true
  end
end
