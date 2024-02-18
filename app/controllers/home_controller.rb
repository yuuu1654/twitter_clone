# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :current_user, only: [:index]
  before_action :logged_in_user?, only: [:index]

  def index
    @user = current_user
    @tweet = Tweet.new
    # ▼他のコントローラからもトップページを描画するので、共通化した
    set_top_page_tweets
  end
end
