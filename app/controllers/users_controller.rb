# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :current_user, only: [:show]
  before_action :set_user, only: %i[show edit]

  def show
    set_specific_tweets
  end

  def edit; end

  def update
    # if @user.update(user_params)
    #   redirect_to user_path(@user)
    # else
    #   # ▼ 何やってるのか調べる ito_junichi
    #   render :edit, status: :unprocessable_entity
    # end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone_number, :birthday, :website, :place, :profile_image,
                                 :avatar_image, :password, :password_confirmation)
  end

  # ツイートコレクションの初期設定
  def set_tweet_collections
    @my_tweets = Tweet.none.page(params[:page])
    @liked_tweets = Tweet.none.page(params[:page])
    @retweeted_tweets = Tweet.none.page(params[:page])
    @commented_tweets = Tweet.none.page(params[:page])
  end

  # タブに応じたツイートのセット
  def set_specific_tweets
    set_tweet_collections
    case params[:tab]
    when 'liked_tweets'
      fetch_liked_tweets
    when 'retweeted_tweets'
      fetch_retweeted_tweets
    when 'commented_tweets'
      fetch_commented_tweets
    else
      fetch_my_tweets
    end
  end

  def fetch_liked_tweets
    @liked_tweets = Tweet.where(content: 'いいねした投稿です').page(params[:page]).per(10)
  end

  def fetch_retweeted_tweets
    @retweeted_tweets = Tweet.where(content: 'リツイートした投稿です').page(params[:page]).per(10)
  end

  def fetch_commented_tweets
    @commented_tweets = Tweet.where(content: 'コメントした投稿です').page(params[:page]).per(10)
  end

  def fetch_my_tweets
    @my_tweets = Tweet.my_tweets(@user.id, params[:page])
  end
end
