# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :users, through: :entries, dependent: :destroy
  has_many :messages, dependent: :destroy

  # 自分と相手のエントリーに紐づいているルームを取得
  def self.shared_room(current_user_id, other_user_id)
    joins('inner join entries as e1 on e1.room_id = rooms.id')
      .joins('inner join entries as e2 on e2.room_id = rooms.id')
      .where('e1.user_id = ? and e2.user_id = ?', current_user_id, other_user_id)
      .distinct
      .first
  end
end
