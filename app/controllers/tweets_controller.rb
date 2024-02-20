# frozen_string_literal: true

class TweetsController < ApplicationController
  def create; end

  def show; end
  def create
    # 1. ログインユーザーの投稿インスタンスをメモリ上に作成
    # 2. 画像を@tweetインスタンスに紐づける
    # 3. 保存(データ永続化)して、成功ならホームページにリダイレクト
    @user = current_user
    @tweet = current_user.tweets.build(tweet_params)
    @tweet.image.attach(params[:tweet][:image])
    if @tweet.save
      redirect_to root_path, notice: 'ツイートしました'
    else
      set_top_page_tweets # トップページ描画に必要なデータを準備
      render template: 'home/index', status: :unprocessable_entity
    end
  end

  def edit; end

  def update; end

  def destroy; end
end
