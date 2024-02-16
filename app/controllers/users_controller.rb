# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :current_user, only: [:show]
  before_action :set_user, only: %i[show edit]

  def show    
    # ツイートがない時にもtotal_pagesメソッドを実行してエラーが出ないようにする
    @my_tweets ||= Tweet.none.page(params[:page])
    @liked_tweets ||= Tweet.none.page(params[:page])
    @retweeted_tweets ||= Tweet.none.page(params[:page])
    @commented_tweets ||= Tweet.none.page(params[:page])
    if params[:tab] == "liked_tweets"
      @liked_tweets = Tweet.where(content: "いいねした投稿です").page(params[:page]).per(10)
    elsif params[:tab] == "retweeted_tweets"
      @retweeted_tweets = Tweet.where(content: "リツイートした投稿です").page(params[:page]).per(10)
    elsif params[:tab] == "commented_tweets"
      @commented_tweets = Tweet.where(content: "コメントした投稿です").page(params[:page]).per(10)
    else
      @my_tweets = Tweet.my_tweets(@user.id, params[:page])
    end
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
end
