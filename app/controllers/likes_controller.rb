# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_like, only: [:destroy]

  def create
    tweet = Tweet.find_by(id: params[:tweet_id])
    current_user.like_tweet(tweet)
    redirect_to request.referer # リクエストを実行した場所に遷移
  end

  def destroy
    @like.destroy
    redirect_to request.referer
  end

  private

  def set_like
    @like = current_user.likes.find_by(id: params[:id])
  end
end
