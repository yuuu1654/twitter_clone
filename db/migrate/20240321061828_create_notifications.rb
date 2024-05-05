# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :subject, polymorphic: true
      t.references :user, foreign_key: true
      t.integer :action_type, null: false
      t.boolean :checked

      t.timestamps
    end
  end
end
