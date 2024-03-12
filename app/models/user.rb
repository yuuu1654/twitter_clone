# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, -> { order('likes.created_at desc') }, through: :likes, source: :tweet # いいねしたツイートの集合
  has_many :retweets, dependent: :destroy
  has_many :retweeted_tweets, lambda {
                                order('retweets.created_at desc')
                              }, through: :retweets, source: :tweet # リツイートしたツイートの集合
  # フォローしている人
  # follower_id : フォローする側のid, このidを持つユーザーが他のユーザーをフォローしているという関係を示す
  has_many :active_relationships, class_name: 'Follow',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy,
                                  inverse_of: :follower
  has_many :following, through: :active_relationships, source: :followed # フォローしている人の集合
  # フォローしてくれている人
  # followed_id : フォローされる側のid, このidを持つユーザーを他のユーザーがフォローしているという関係を示す
  has_many :passive_relationships, class_name: 'Follow',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy,
                                   inverse_of: :followed
  has_many :followers, through: :active_relationships, source: :follower # フォロワーの集合

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

  # リツイート関連
  def retweeted?(tweet)
    retweeted_tweets.include?(tweet)
  end

  def retweet_tweet(tweet)
    retweets.create(tweet_id: tweet.id)
  end

  # ▼使わなかったので、一旦コメントアウト
  # def unretweet_tweet(user, tweet)
  #   retweet = Retweet.find_by(user_id: user.id, tweet_id: tweet.id)
  #   retweet&.destroy
  # end

  # フォロー関連
  def follow(other_user)
    # 関連づけられたオブジェクト(other_user)が、既にデータベースに保存されている場合のみ<<が使えるっぽい
    following << other_user
    # 以下でも同様に動作した
    # active_relationships.create!(followed_id: other_user.id)
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
