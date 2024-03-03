# frozen_string_literal: true

class User < ApplicationRecord
  # test
  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, -> { order('likes.created_at desc') }, through: :likes, source: :tweet # いいねしたツイートの集合
  has_one_attached :avatar_image
  has_one_attached :profile_image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable,
         :timeoutable, :trackable, :omniauthable, omniauth_providers: %i[github] # ← githubでのOAuthに対応させる

  validates :birthday, presence: true

  # ▼uidを必須にした上で、providerカラムの範囲内でuidを一意にする
  validates :uid, presence: true, uniqueness: { scope: :provider }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = SecureRandom.alphanumeric(7)
      user.email = auth.info.email.presence || "dummy+#{auth.uid}@example.com"
      user.password = Devise.friendly_token[0, 20]
      user.birthday = Date.new(1900, 1, 1) # デフォルトの誕生日（必要に応じて変更）
      user.phone_number = "090#{rand(10_000_000..99_999_999)}"
      user.username = "@#{SecureRandom.alphanumeric(7)}"
    end
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.create_username
    "@#{SecureRandom.alphanumeric(7)}"
  end

  # いいね関連
  def liked?(tweet)
    liked_tweets.include?(tweet)
  end

  def like_tweet(tweet)
    likes.create(tweet_id: tweet.id)
  end

  def unlike_tweet(user, tweet)
    like = Like.find_by(user_id: user.id, tweet_id: tweet.id)
    like&.destroy
  end
end
