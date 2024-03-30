# frozen_string_literal: true

class MessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.build(message_params)
    @message.sender = current_user
    @message.recipient = User.find(params[:other_user_id])
    if @message.save
      redirect_to room_show_path(params[:room_id])
    else
      render template: 'rooms/show', status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
