# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :logged_in_user?, only: %i[index show]
  before_action :set_rooms, only: %i[index show]
  before_action :set_room, only: [:show]
  before_action :set_other_user, only: [:show]

  def create
    other_user = User.find(params[:user_id])
    # 自分と相手がすでに参加しているルームを探す
    shared_room = Room.shared_room(current_user.id, other_user.id)

    if shared_room
      redirect_to room_show_path(shared_room.id)
    else
      @room = Room.create do |room|
        room.entries.build(user: current_user)
        room.entries.build(user: other_user)
      end
      redirect_to room_show_path(@room)
    end
  end

  def index; end

  def show
    @message = Message.new
    @messages = @room.messages.order(created_at: :asc)
  end

  private

  def set_rooms
    @rooms = current_user.rooms.includes(:messages)
  end

  def set_room
    @room = Room.includes(:messages).find_by(id: params[:room_id])
  end

  def set_other_user
    @other_user = @room.users.where.not(id: current_user.id).first
  end
end
