# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :set_other_user, only: %i[create destroy]

  def create
    current_user.follow(@other_user)
    redirect_to request.referer # リクエストを実行した場所に遷移
  end

  def destroy
    current_user.unfollow(@other_user)
    redirect_to request.referer
  end

  private

  def set_other_user
    # @relationship = Follow.find_by(followed_id: params[:followed_id])
    @other_user = User.find_by(id: params[:followed_id])
  end
end
