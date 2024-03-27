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

  def bookmark_or_unbookmark_button(user, tweet)
    bookmark = Bookmark.find_by(user_id: user.id, tweet_id: tweet.id)
    bookmarks_count = tweet.bookmarks.count
    if user.bookmarked?(tweet)
      link_to bookmark_path(bookmark), method: :delete, data: { turbo_method: :delete },
                                       class: 'bookmark-btn-unbookmark__link' do
        tag.i('', class: 'bi bi-bookmark-fill bookmark-btn-unbookmark') + " #{bookmarks_count}"
      end
    else
      link_to bookmarks_path(tweet_id: tweet.id), method: :post, data: { turbo_method: :post },
                                                  class: 'bookmark-btn__link' do
        tag.i('', class: 'bi bi-bookmark bookmark-btn') + " #{bookmarks_count}"
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
    if current_user.following?(other_user)
      link_to relationship_path(followed_id: other_user.id), method: :delete, data: { turbo_method: :delete },
                                                             class: 'user-action-link dropdown-item' do
        content_tag(:i, '', class: 'bi bi-person-dash') + " #{other_user.name}さんのフォローをやめる"
      end
    else
      link_to relationships_path(followed_id: other_user.id), method: :post, data: { turbo_method: :post },
                                                              class: 'user-action-link dropdown-item' do
        content_tag(:i, '', class: 'bi bi-person-plus') + " #{other_user.name}さんをフォローする"
      end
    end
  end
end
