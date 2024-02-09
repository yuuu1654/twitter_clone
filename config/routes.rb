# frozen_string_literal: true

Rails.application.routes.draw do
  # dev環境でメール送信を確認
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root 'home#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    # ▼OAuthのcallback用ルーティング
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  post "/tweets", to: "tweets#create"
end
