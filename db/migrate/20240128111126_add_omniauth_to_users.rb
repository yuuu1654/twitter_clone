# frozen_string_literal: true

class AddOmniauthToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :provider, :string, null: false, default: ''
    add_column :users, :uid, :string, null: false, default: ''

    # uidとproviderのカラムの組み合わせに対して一意の制約をつける
    add_index :users, %i[uid provider], unique: true
  end
end
