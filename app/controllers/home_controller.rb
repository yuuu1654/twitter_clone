# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :logged_in_user?, only: [:index]

  def index
    @tweet = Tweet.new # ツイートフォーム表示させる為
    # ▼他のコントローラからもトップページを描画するので、共通化した
    set_top_page_tweets
  end
end
