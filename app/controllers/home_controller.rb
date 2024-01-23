# frozen_string_literal: true

class HomeController < ApplicationController
  def top
    @current_user = current_user
    logger.debug "ログインユーザー情報: #{@current_user.inspect}"
  end
end
