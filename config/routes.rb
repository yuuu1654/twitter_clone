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

  # get '/users/show', to: 'users#show'
  # get '/users/:id', to: 'users#show' ← なぜかヘルパーURLが生成されない？ user_path(@user)
  # resources :users, only: [:show, :edit]
  resources :users

  # post '/tweets/create', to: 'tweets#create'
  # get '/tweets/:id', to: 'tweets#show'
  resources :tweets
  resources :comments

  # いいね
  # ▼動く事確認済み (分かり易いURLヘルパーメソッドを使いたい為、resourcesを使用)
  # post "/likes/:tweet_id/create", to: "likes#create"
  # delete "/likes/:tweet_id/destroy", to: "likes#destroy"
  resources :likes, only: %i[create destroy]

  # リツイート
  resources :retweets, only: %i[create destroy]

  # フォロー
  resources :relationships, only: %i[create destroy]

  # ブックマーク
  resources :bookmarks, only: %i[index create destroy]

  # メッセージ
  resources :messages, only: %i[create]
  get '/messages', to: 'rooms#index'
  post '/messages/:user_id', to: 'rooms#create', as: 'rooms'
  get '/messages/:room_id', to: 'rooms#show', as: 'room_show'

  # 通知
  resources :notifications, only: [:index]
end
