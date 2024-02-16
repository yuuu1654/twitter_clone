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

  post '/tweets', to: 'tweets#create'

  # get '/users/show', to: 'users#show'
  # get '/users/:id', to: 'users#show' ← なぜかヘルパーURLが生成されない？ user_path(@user)
  # resources :users, only: [:show, :edit]
  resources :users
end
