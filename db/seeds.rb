# frozen_string_literal: true

# テスト用ユーザー1 (自分)
# User.create!(
#   name: '本番テスト用1',
#   email: 'test-prd01@gmail.com',
#   password: 'testprd01',
#   birthday: Date.new(2000, 1, 1),
#   phone_number: "090#{rand(10_000_000..99_999_999)}",
#   uid: User.create_unique_string
# )

# # テスト用ユーザー2 (フォロー対象ユーザー)
# user2 = User.create!(
#   name: '本番テスト用2',
#   email: 'test-prd02@gmail.com',
#   password: 'testprd02',
#   birthday: Date.new(2000, 1, 1),
#   phone_number: "090#{rand(10_000_000..99_999_999)}",
#   uid: User.create_unique_string
# )

# # テスト用ユーザー3 (フォローしていないユーザー)
# user3 = User.create!(
#   name: '本番テスト用3',
#   email: 'test-prd03@gmail.com',
#   password: 'testprd03',
#   birthday: Date.new(2000, 1, 1),
#   phone_number: "090#{rand(10_000_000..99_999_999)}",
#   uid: User.create_unique_string
# )

# サンプルユーザー作成
# 30.times do |n|
#   name = "user#{n}"
#   email = "hoge-#{n}@gmail.com"
#   password = Devise.friendly_token[0, 20]
#   birthday = Date.new(2000, 1, 1)
#   phone_number = "090#{rand(10_000_000..99_999_999)}"
#   username = "@#{SecureRandom.alphanumeric(7)}"
#   uid = User.create_unique_string
#   User.create!(name:,
#                email:,
#                password:,
#                birthday:,
#                phone_number:,
#                uid:,
#                username:)
# end

# # ツイート作成 (フォローしてない人)
# 10.times do |_n|
#   user_id = user3.id
#   sample_sentences = [
#     '今日は良い天気ですね。',
#     '最近読んだ本が面白かった。',
#     '明日は友達と映画を見に行きます。',
#     '新しいレストランを試してみたい。',
#     '週末は家でゆっくり過ごしたい。',
#     '今日学んだことを忘れないようにしよう。',
#     '音楽を聴きながら勉強するのが好き。',
#     '旅行の計画を立て始めた。',
#     '美味しいコーヒーの淹れ方を学びたい。',
#     '運動することで気分が良くなった。',
#     'サッカーと野球どっち派？もしかして卓球派？'
#   ]
#   # サンプルツイートからランダムに一つ選ぶ
#   content = sample_sentences.sample
#   Tweet.create!(user_id:,
#                 content:)
# end

# # ツイート作成 (フォローしてる人)
# 10.times do |_n|
#   user_id = user2.id
#   sample_sentences = [
#     '今日は良い天気ですね。',
#     '最近読んだ本が面白かった。',
#     '明日は友達と映画を見に行きます。',
#     '新しいレストランを試してみたい。',
#     '週末は家でゆっくり過ごしたい。',
#     '今日学んだことを忘れないようにしよう。',
#     '音楽を聴きながら勉強するのが好き。',
#     '旅行の計画を立て始めた。',
#     '美味しいコーヒーの淹れ方を学びたい。',
#     '運動することで気分が良くなった。',
#     'サッカーと野球どっち派？もしかして卓球派？'
#   ]
#   # サンプルツイートからランダムに一つ選ぶ
#   content = sample_sentences.sample
#   Tweet.create!(user_id:,
#                 content:)
# end

# いいねデータ作成
# tweets = Tweet.all
# test_user = User.find_by(email: 'test-prd01@gmail.com')
# liked_tweets = tweets[15..20]
# liked_tweets.each { |tweet| test_user.like_tweet(tweet) }

# リツイートデータ作成
# tweets = Tweet.all
# test_user = User.find_by(email: 'test-prd01@gmail.com')
# retweeted_tweets = tweets[15..20]
# retweeted_tweets.each { |tweet| test_user.retweet_tweet(tweet) }

# フォロー関係作成
# users = User.all
# user = User.find_by(email: 'test-prd01@gmail.com')
# following = users[9..30]
# followers = users[8..25]
# following.each do |followed|
#   user.follow(followed) unless user == followed
# end
# followers.each do |follower|
#   follower.follow(user) unless user == follower
# end

# いいね・リツイート・コメントしたツイートの確認用データ
# test_user = User.find_by(email: 'test-prd01@gmail.com')
# test_user = User.find_by(id: 20)
# 10.times do |_n|
#   user_id = test_user.id
#   sample_sentences = %w[
#     いいねした投稿です
#     リツイートした投稿です
#     コメントした投稿です
#   ]
#   # サンプルツイートからランダムに一つ選ぶ
#   content = sample_sentences.sample
#   Tweet.create!(user_id:,
#                 content:)
# end

user1 = User.find_or_create_by!(email: 'test-prd01@gmail.com') do |user|
  user.name = '本番テスト用1'
  user.password = 'testprd01'
  user.birthday = Date.new(2000, 1, 1)
  user.phone_number = "090#{rand(10_000_000..99_999_999)}"
  user.uid = User.create_unique_string
end

user2 = User.find_or_create_by!(email: 'test-prd02@gmail.com') do |user|
  user.name = '本番テスト用1'
  user.password = 'testprd01'
  user.birthday = Date.new(2000, 1, 1)
  user.phone_number = "090#{rand(10_000_000..99_999_999)}"
  user.uid = User.create_unique_string
end

# テスト用ツイート
tweet = Tweet.create!(user: user1, content: 'user1のツイートです')

# いいね通知
like = Like.create!(user: user2, tweet:)
Notification.create!(
  subject: like,
  user: user1,
  action_type: 1,
  checked: false
)

# リツイート通知の作成
retweet = Retweet.create!(user: user2, tweet:)
Notification.create!(
  subject: retweet,
  user: user1,
  action_type: 3,
  checked: false
)

# フォロー通知
follow = Follow.create!(follower: user2, followed: user1)
Notification.create!(
  subject: follow,
  user: user1,
  action_type: 2,
  checked: false
)

# コメント通知
comment = Comment.create!(user: user2, tweet:, content: 'user2が、user1のツイートにコメントしました')
Notification.create!(
  subject: comment,
  user: user1,
  action_type: 0,
  checked: false
)
