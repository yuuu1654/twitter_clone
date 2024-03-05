# frozen_string_literal: true

class RetweetsController < ApplicationController
  before_action :set_retweet, only: [:destroy]

  def create
    @tweet = Tweet.find_by(id: params[:tweet_id])
    current_user.retweet_tweet(@tweet)
    # @tweet.touch ← モデルのバリデーションをスキップするので好ましくない..
    @tweet.update(updated_at: Time.current)
    redirect_to request.referer
  end

  def destroy
    @tweet = Tweet.find_by(id: @retweet.tweet_id)
    @retweet.destroy
    @tweet.update(updated_at: @tweet.created_at)
    redirect_to request.referer
  end

  private

  def set_retweet
    @retweet = current_user.retweets.find_by(id: params[:id])
  end
end
