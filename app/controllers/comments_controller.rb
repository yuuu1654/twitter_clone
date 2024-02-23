# frozen_string_literal: true

class CommentsController < ApplicationController
  # コメントコントローラはコメント作成の責務のみ

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to tweet_path(params[:tweet_id]), notice: 'コメントしました'
    else
      set_comments
      render template: 'tweets/show', status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:tweet_id, :content)
  end
end
