# frozen_string_literal: true

# # resources :likes の場合
module TweetsHelper
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

  def retweet_or_unretweet_button(user, tweet)
    retweet = Retweet.find_by(user_id: user.id, tweet_id: tweet.id)
    retweets_count = tweet.retweets.count
    if user.retweeted?(tweet)
      link_to retweet_path(retweet), method: :delete, data: { turbo_method: :delete },
                                     class: 'retweet-btn-unretweet__link' do
        tag.i('', class: 'bi bi-repeat retweet-btn-unretweet') + " #{retweets_count}"
      end
    else
      link_to retweets_path(tweet_id: tweet.id), method: :post, data: { turbo_method: :post },
                                                 class: 'retweet-btn__link' do
        tag.i('', class: 'bi bi-repeat retweet-btn') + " #{retweets_count}"
      end
    end
  end

  def follow_or_unfollow_button(current_user, other_user)
    Follow.find_by(follower_id: current_user.id, followed_id: other_user.id)
    if current_user.following?(other_user)
      link_to relationship_path(followed_id: other_user.id), method: :delete, data: { turbo_method: :delete },
                                                             class: 'user-action-link dropdown-item' do
        'フォローをやめる'
      end
    else
      link_to relationships_path(followed_id: other_user.id), method: :post, data: { turbo_method: :post },
                                                              class: 'user-action-link dropdown-item' do
        'フォローする'
      end
    end
  end
end
