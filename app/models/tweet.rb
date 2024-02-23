# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :retweets, dependent: :destroy
  has_many :retweeted_users, through: :retweets, source: :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :image, content_type: { in: ['image/jpeg', 'image/gif', 'image/png'], message: '適切な画像フォーマットを使用してください' }

  # ツイート一覧取得
  scope :recommended_tweets, lambda { |page|
    includes(:user)
      .order(updated_at: :desc)
      .page(page)
      .per(10)
  }

  # フォローしてるツイート取得
  scope :following_tweets, lambda { |user_id, page|
    where(user_id:)
      .includes(:user)
      .order(created_at: :desc)
      .page(page)
      .per(10)
  }

  # 自分のツイート
  scope :my_tweets, lambda { |user_id, page|
    where(user_id:)
      .includes(:user)
      .order(updated_at: :desc)
      .page(page)
      .per(10)
  }

  # いいねしたツイート
  # scope :liked_tweets, lambda { |user_id, _tweet_id, page|
  #   where(user_id:)
  #     .includes(:user)
  #     .order(created_at: :desc)
  #     .page(page)
  #     .per(10)
  # }
end
