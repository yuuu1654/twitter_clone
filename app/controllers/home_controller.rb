# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :current_user, only: [:index]
  before_action :logged_in_user?, only: [:index]

  def index
    @user = current_user
    @tweet = Tweet.new

    # 空の結果セットもページネーションオブジェクトとして扱う
    @recommended_tweets ||= Tweet.none.page(params[:page])
    @following_tweets ||= Tweet.none.page(params[:page])
    if params[:tab] == 'following'
      # フォローしているユーザーのツイート一覧
      followed_user_id = User.find_by(email: 'test-prd02@gmail.com')
      @following_tweets = Tweet.following_tweets(followed_user_id, params[:page])
    else
      # おすすめツイート
      @recommended_tweets = Tweet.recommended_tweets(params[:page])
    end
  end
end
