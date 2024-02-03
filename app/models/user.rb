# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable, :omniauthable

  validates :birthday, presence: true
  # ▼uidを必須にした上で、providerカラムの範囲内でuidを一意にする
  validates :uid, presence: true, uniqueness: { scope: :provider }
end
