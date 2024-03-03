# frozen_string_literal: true

class RecreateCommentsMigration < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tweet, null: false, foreign_key: true
      t.text :content, null: false
      t.timestamps
    end
  end
end
