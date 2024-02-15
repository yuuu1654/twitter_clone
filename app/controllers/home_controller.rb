# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :current_user, only: [:index]
  before_action :logged_in_user?, only: [:index]

  def index
    @user = current_user
    logger.debug "ユーザー情報: #{@user.inspect}"
    @tweet = Tweet.new

    # タブに応じてツイートを取得
    # case params[:tab]
    # when 'following'
    #   # フォローしているユーザーのツイート一覧
    #   followed_user_id = User.find_by(email: 'test-prd02@gmail.com')
    #   @following_tweets = Tweet.where(user_id: followed_user_id).includes(:user).order(created_at: :desc).page(params[:page]).per(10)
    #   logger.debug "@following_tweets: #{@following_tweets.inspect}"
    # else
    #   # おすすめツイート
    #   @recommended_tweets = Tweet.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
    # end

    if params[:tab] == "following"
      # フォローしているユーザーのツイート一覧
      followed_user_id = User.find_by(email: 'test-prd02@gmail.com')
      @following_tweets = Tweet.where(user_id: followed_user_id).includes(:user).order(created_at: :desc).page(params[:page]).per(10)
      logger.debug "@following_tweets: #{@following_tweets.inspect}"
    else
      # おすすめツイート
      @recommended_tweets = Tweet.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
    end
  
    # 空の結果セットもページネーションオブジェクトとして扱う
    @following_tweets ||= Tweet.none.page(params[:page])
    @recommended_tweets ||= Tweet.none.page(params[:page])
  end
end
