# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  has_one_attached :images

  # ツイート一覧取得
  scope :recommended_tweets, lambda { |page|
    includes(:user)
      .order(created_at: :desc)
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
      .order(created_at: :desc)
      .page(page)
      .per(10)
  }
  }
end
