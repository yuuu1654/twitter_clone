class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      # usersテーブルのFKに設定
      t.references :follower, null: false, foreign_key: { to_table: :users }
      t.references :followed, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    # 同じフォロワーとフォローしている人の組み合わせがないようにする
    add_index :follows, [:follower_id, :followed_id], unique: true
    
    # 自分自身をフォローする事もないので、そういった組み合わせもないようにする
    add_check_constraint :follows, "follower_id != followed_id", name: "follows_follower_id_followed_id_check"
  end
end
