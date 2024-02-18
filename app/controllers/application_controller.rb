# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private

  def logged_in_user?
    return if user_signed_in?
    redirect_to new_user_session_path
  end

  def set_top_page_tweets
    # 空の結果セットもページネーションオブジェクトとして扱う
    @recommended_tweets ||= Tweet.none.page(params[:page])
    @following_tweets ||= Tweet.none.page(params[:page])
    if params[:tab] == 'following'
      followed_user_id = User.find_by(email: 'test-prd02@gmail.com')
      @following_tweets = Tweet.following_tweets(followed_user_id, params[:page])
    else
      @recommended_tweets = Tweet.recommended_tweets(params[:page])
    end
  end
end
