# frozen_string_literal: true

class NotificationsController < ApplicationController
  before_action :logged_in_user?, only: [:index]

  def index
    @notifications = current_user.notifications.order(created_at: :desc)
    # @notifications.where(checked: false).find_each do |notification|
    #   notification.update(checked: true)
    # end
    # ▼update_allを用いて一斉更新するようリファクタ (←バリデーションをスキップしてしまうrubocopエラーの為コメントアウト)
    # @notifications.update_all(checked: true)
    @notifications.each { |notification| notification.update(checked: true) }
  end

  def destroy
    @notifications = current_user.notifications.destroy_all
    redirect_to notifications_path
  end
end
