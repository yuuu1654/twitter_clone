#!/usr/bin/env bash
# exit on error
set -o errexit # 途中でエラーが発生した時に残りのコマンドが実行されるのを防ぐ


bundle install
rails assets:precompile
rails assets:clean
# DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rails db:reset
rails db:migrate
# rails db:seed

# Renderコンソールに設定用のコマンド▼
# デフォルト▼
# bundle install && rails assets:precompile && rails assets:clean && rails db:migrate

# bundle install && rails assets:precompile && rails assets:clean && rails db:migrate && rails db:seed && rails user:attach_images

# bundle install && rails assets:precompile && rails assets:clean && rails db:create && rails db:migrate