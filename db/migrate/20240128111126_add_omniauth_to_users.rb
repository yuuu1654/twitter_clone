# frozen_string_literal: true

class AddOmniauthToUsers < ActiveRecord::Migration[7.0]
  def change
    # change_tableを使用して一括でカラムを追加
    change_table :users, bulk: true do |t|
      t.column :provider, :string, null: false, default: ''
      t.column :uid, :string, null: false, default: ''
    end

    # uidとproviderのカラムの組み合わせに対して一意の制約をつける
    add_index :users, %i[uid provider], unique: true
  end
end
