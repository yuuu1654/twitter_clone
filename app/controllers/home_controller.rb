# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @current_user = current_user
    logger.debug "ログインユーザー情報: #{@current_user.inspect}"
    @tweet = Tweet.new

    # おすすめツイート
    @recommended_tweets = Tweet.all.order(created_at: :desc).page(params[:page]).per(10)

    # フォローしてるユーザーのツイート一覧 (本番テストの為、一時的に直でidを指定 <- フォロー機能実装時に修正)
    followed_user_id = User.find_by(email: "test-prd02@gmail.com")
    # @following_tweets = Tweet.where(user_id: 14).page(params[:page]).per(10)
    @following_tweets = Tweet.where(user_id: followed_user_id).page(params[:page]).per(10)
  end
end