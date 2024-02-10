# frozen_string_literal: true

# TODO: フォロー機能作る時に関連性を整理する
# ユーザー作成

# テスト用ユーザー1 (自分)
name  = '本番テスト用1'
email = 'test-prd01@gmail.com'
password = 'testprd01'
birthday = Date.new(2000, 1, 1)
phone_number = "090#{rand(10_000_000..99_999_999)}"
uid = User.create_unique_string
User.create!(name:,
             email:,
             password:,
             birthday:,
             phone_number:,
             uid:)

# テスト用ユーザー2 (フォロー対象ユーザー)
name  = '本番テスト用2'
email = 'test-prd02@gmail.com'
password = 'testprd02'
birthday = Date.new(2000, 1, 1)
phone_number = "090#{rand(10_000_000..99_999_999)}"
uid = User.create_unique_string
User.create!(name:,
             email:,
             password:,
             birthday:,
             phone_number:,
             uid:)

# 10.times do |n|
#   name  = "user#{n+10}"
#   email = "example-#{n+10}@gmail.com"
# 	password = Devise.friendly_token[0, 20]
# 	birthday = Date.new(2000, 1, 1)
# 	phone_number = "090#{rand(10_000_000..99_999_999)}"
# 	uid = User.create_unique_string
#   User.create!(name: name,
#               email: email,
#               password: password,
#               birthday: birthday,
#               phone_number: phone_number,
# 							uid: uid)
# end

# ツイート作成 (フォローしてない人)
not_followed_user = User.find_by(name: "iIetF2W")
10.times do |_n|
  user_id = not_followed_user.id
  sample_sentences = [
    '今日は良い天気ですね。',
    '最近読んだ本が面白かった。',
    '明日は友達と映画を見に行きます。',
    '新しいレストランを試してみたい。',
    '週末は家でゆっくり過ごしたい。',
    '今日学んだことを忘れないようにしよう。',
    '音楽を聴きながら勉強するのが好き。',
    '旅行の計画を立て始めた。',
    '美味しいコーヒーの淹れ方を学びたい。',
    '運動することで気分が良くなった。',
    'サッカーと野球どっち派？もしかして卓球派？'
  ]
  # サンプルツイートからランダムに一つ選ぶ
  content = sample_sentences.sample
  Tweet.create!(user_id:,
                content:)
end

# ツイート作成 (フォローしてる人)
10.times do |_n|
  user_id = User.find_by(email: 'test-prd02@gmail.com').id
  sample_sentences = [
    '今日は良い天気ですね。',
    '最近読んだ本が面白かった。',
    '明日は友達と映画を見に行きます。',
    '新しいレストランを試してみたい。',
    '週末は家でゆっくり過ごしたい。',
    '今日学んだことを忘れないようにしよう。',
    '音楽を聴きながら勉強するのが好き。',
    '旅行の計画を立て始めた。',
    '美味しいコーヒーの淹れ方を学びたい。',
    '運動することで気分が良くなった。',
    'サッカーと野球どっち派？もしかして卓球派？'
  ]
  # サンプルツイートからランダムに一つ選ぶ
  content = sample_sentences.sample
  Tweet.create!(user_id:,
                content:)
end

# ユーザー
User.all
test_user = User.find_by(email: 'test-prd01@gmail.com')
followed_user = User.find_by(email: 'test-prd02@gmail.com')

# フォロー関係作成
Follow.find_or_create_by(follower_id: test_user.id, followed_id: followed_user.id)

# フォロー機能を作る時に実装
# users = User.all
# user  = users.first
# following = users[2..50]
# followers = users[3..40]
# following.each { |followed| user.follow(followed) }
# followers.each { |follower| follower.follow(user) }
