# frozen_string_literal: true

# # resources :likes の場合
module UsersHelper
  def like_or_unlike_button(user, tweet)
    like = Like.find_by(user_id: user.id, tweet_id: tweet.id)
    likes_count = tweet.likes.count
    if user.liked?(tweet)
      link_to like_path(like), method: :delete, data: { turbo_method: :delete }, class: 'like-btn-unlike__link' do
        tag.i('', class: 'bi bi-heart-fill like-btn-unlike') + " #{likes_count}"
      end
    else
      link_to likes_path(tweet_id: tweet.id), method: :post, data: { turbo_method: :post }, class: 'like-btn__link' do
        tag.i('', class: 'bi bi-heart like-btn') + " #{likes_count}"
      end
    end
  end
end
