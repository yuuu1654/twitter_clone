# frozen_string_literal: true

class RemoveUserIdFromRooms < ActiveRecord::Migration[7.0]
  def change
    remove_column :rooms, :user_id, :bigint
  end
end
