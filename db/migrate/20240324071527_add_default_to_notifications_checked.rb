# frozen_string_literal: true

class AddDefaultToNotificationsChecked < ActiveRecord::Migration[7.0]
  def change
    change_column_default :notifications, :checked, from: nil, to: false
  end
end
