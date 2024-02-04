# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable, :omniauthable, omniauth_providers: %i[github] # ← githubでのOAuthに対応させる
  
  validates :birthday, presence: true

  # ▼uidを必須にした上で、providerカラムの範囲内でuidを一意にする
  validates :uid, presence: true, uniqueness: { scope: :provider }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      logger.debug "authの中身: #{auth.info.inspect}"
      logger.debug "ユーザー属性: #{user.attributes.inspect}"
      user.name = SecureRandom.alphanumeric(7)
      user.email = auth.info.email.presence || "dummy+#{auth.uid}@example.com"
      user.password = Devise.friendly_token[0, 20]
      user.birthday = Date.new(1900,1,1) # デフォルトの誕生日（必要に応じて変更）
      user.phone_number = "090" + rand(10000000..99999999).to_s
    end
  end

  def self.create_unique_string
    SecureRandom.uuid
  end
end
