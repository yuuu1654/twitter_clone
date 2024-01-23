# frozen_string_literal: true

Rails.application.routes.draw do
  # dev環境でメール送信を確認
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root 'home#top'
  # devise_for :users # Deviseのデフォルトのルーティング

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # Deviseが提供するルートのパスまたは名前をオーバーライドするために使う
  devise_scope :user do
    # ▼現状なくても動いてる為コメントアウト
    # get "users/sign_up", to: "registrations#new"
    # get "users/sign_in", to: "sessions#new"
  end
end
