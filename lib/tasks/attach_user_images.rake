# frozen_string_literal: true

namespace :user do
  desc 'Attach images to user'
  task attach_images: :environment do
    # 実行コマンド :
    test_user = User.find_by(email: 'test-prd01@gmail.com')
    user_id = test_user.id
    avatar_path = Rails.root.join('app/assets/images/user-icon.png')
    profile_path = Rails.root.join('app/assets/images/user-prof-bgimg.jpeg')

    exit unless user_id && avatar_path && profile_path

    user = User.find_by(id: user_id)
    unless user
      puts "ユーザーが存在しません...: #{user_id}"
      exit
    end

    # Attach avatar_image
    if File.exist?(avatar_path)
      user.avatar_image.attach(io: File.open(avatar_path), filename: 'user-icon.png')
      puts 'アイコン画像のデータを紐付けました'
    else
      puts 'アイコン画像のデータが存在しません'
    end

    # Attach profile_image
    if File.exist?(profile_path)
      user.profile_image.attach(io: File.open(profile_path), filename: 'user-prof-bgimg.jpeg')
      puts 'プロフィール画像のデータを紐付けました'
    else
      puts 'プロフィール画像のデータが存在しません'
    end
  end
end
