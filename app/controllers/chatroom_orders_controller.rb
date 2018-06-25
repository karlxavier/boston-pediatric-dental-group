class ChatroomOrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom, except: [:index]

  def index
    if current_user.admin?
      @chatroom_orders = ChatroomOrder.order(id: :desc)
    else
      @chatroom_orders = ChatroomOrder.only_my_chatrooms(current_user.id).order(id: :desc)
    end
  end

  def load_messages
      respond_to do |format|
        # @chatroom = Chatroom.find(params[:chatroom_id])
        @messages = @chatroom.messages.order(created_at: :desc).limit(100).reverse
        # @unread_count = Message.unread_count(current_user.id, @chatroom.id, @chatroom.chatroom_users.first.last_read_at)

        # chatroom_user = ChatroomUser.where(chatroom_id: @chatroom.id, user_id: current_user.id).first
        # chatroom_user.update_attributes(last_read_at: Time.zone.now)

        format.js
      end
  end

  private
      def set_chatroom
        @chatroom = ChatroomOrder.find(params[:chatroom_order_id])
      end

end