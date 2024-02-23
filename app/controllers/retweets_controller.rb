# frozen_string_literal: true

class RetweetsController < ApplicationController
  before_action :set_retweet, only: [:destroy]

  def create
    @tweet = Tweet.find_by(id: params[:tweet_id])
    current_user.retweet_tweet(@tweet)
    # ツイートのupdated_atを現在時刻に更新
    @tweet.touch
    redirect_to request.referer # リクエストを実行した場所に遷移
  end

  def destroy
    @tweet = Tweet.find_by(id: @retweet.tweet_id)
    @retweet.destroy
    # ツイートのupdated_atをツイート作成時に戻す
    @tweet.updated_at = @tweet.created_at
    @tweet.save
    redirect_to request.referer
  end

  private

  def set_retweet
    @retweet = current_user.retweets.find_by(id: params[:id])
  end
end
