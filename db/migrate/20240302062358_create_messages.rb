# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      # usersテーブルのFKに設定 (t.referencesを使用する場合、カラム名にはidをつけない)
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.text :body

      t.timestamps
    end

    # 自分自身にはメッセージしない仕様なので、そういった組み合わせは無いようにする
    add_check_constraint :messages, 'sender_id != recipient_id', name: 'messages_sender_id_recipient_id_check'
  end
end
