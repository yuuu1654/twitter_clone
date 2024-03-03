# frozen_string_literal: true

class TweetsController < ApplicationController
  before_action :logged_in_user?, only: [:show]
  before_action :set_tweet, only: [:show]

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

  def show
    @comment = Comment.new # コメントフォーム表示させる為
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def tweet_params
    params.require(:tweet).permit(:content, :image)
  end
end
