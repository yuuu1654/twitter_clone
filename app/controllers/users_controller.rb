# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :current_user, only: [:show]
  before_action :set_user, only: %i[show edit]

  def show
    @my_tweets = Tweet.includes(:user).where(user_id: @user.id).order(created_at: :desc)
    logger.debug "ログインユーザー: #{@user.inspect}"
    logger.debug "自分のツイート一覧: #{@my_tweets.inspect}"
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
