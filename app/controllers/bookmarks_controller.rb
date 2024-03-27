# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:destroy]

  def index
    @bookmarked_tweets = current_user.bookmarked_tweets.page(params[:page]).per(10)
  end

  def create
    tweet = Tweet.find_by(id: params[:tweet_id])
    current_user.bookmark_tweet(tweet)
    redirect_to request.referer
  end

  def destroy
    @bookmark.destroy
    redirect_to request.referer
  end

  private

  def set_bookmark
    @bookmark = current_user.bookmarks.find_by(id: params[:id])
  end
end
