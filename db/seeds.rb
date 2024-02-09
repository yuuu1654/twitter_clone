# TODO: フォロー機能作る時に関連性を整理する
# ユーザー作成
10.times do |n|
  name  = "user#{n+10}"
  email = "example-#{n+10}@gmail.com"
	password = Devise.friendly_token[0, 20]
	birthday = Date.new(2000, 1, 1) 
	phone_number = "090#{rand(10_000_000..99_999_999)}"
	uid = User.create_unique_string
  User.create!(name: name,
              email: email,
              password: password,
              birthday: birthday,
              phone_number: phone_number,
							uid: uid)
end

# ツイート作成
10.times do |n|
	user_id = 14
	sample_sentences = [
    "今日は良い天気ですね。",
    "最近読んだ本が面白かった。",
    "明日は友達と映画を見に行きます。",
    "新しいレストランを試してみたい。",
    "週末は家でゆっくり過ごしたい。",
    "今日学んだことを忘れないようにしよう。",
    "音楽を聴きながら勉強するのが好き。",
    "旅行の計画を立て始めた。",
    "美味しいコーヒーの淹れ方を学びたい。",
    "運動することで気分が良くなった。"
  ]
  # サンプルツイートからランダムに一つ選ぶ
  content = sample_sentences.sample
	Tweet.create!(user_id: user_id,
								content: content)
end

10.times do |n|
	user_id = 35
	sample_sentences = [
    "今日は良い天気ですね。",
    "最近読んだ本が面白かった。",
    "明日は友達と映画を見に行きます。",
    "新しいレストランを試してみたい。",
    "週末は家でゆっくり過ごしたい。",
    "今日学んだことを忘れないようにしよう。",
    "音楽を聴きながら勉強するのが好き。",
    "旅行の計画を立て始めた。",
    "美味しいコーヒーの淹れ方を学びたい。",
    "運動することで気分が良くなった。"
  ]
  # サンプルツイートからランダムに一つ選ぶ
  content = sample_sentences.sample
	Tweet.create!(user_id: user_id,
								content: content)
end

# ユーザー
users = User.all
user1 = User.find_by(id: 13)
user2 = User.find_by(id: 14)

# すべてのユーザーをループし、user1がそれぞれをフォローするように設定
users.each do |user|
  # user1が自分自身をフォローしないようにチェック
  unless user == user1
    # フォロー関係を作成または検索し、既に存在しない場合にのみ作成
    Follow.find_or_create_by(follower_id: user1.id, followed_id: user.id)
  end
end

# フォロー機能を作る時に実装
# users = User.all
# user  = users.first
# following = users[2..50]
# followers = users[3..40]
# following.each { |followed| user.follow(followed) }
# followers.each { |follower| follower.follow(user) }





