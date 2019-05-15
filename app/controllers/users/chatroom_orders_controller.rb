class Users::ChatroomOrdersController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_chatroom, except: [:index, :update]

  def index
    # if current_user.admin?
    #   @chatroom_orders = ChatroomOrder.order(id: :desc)
    # else
    #   @chatroom_orders = ChatroomOrder.only_my_chatrooms(current_user.id).order(id: :desc)
    # end
    @chatroom_orders = ChatroomOrder.order(id: :desc)
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

  def update
    respond_to do |format|
      order_user_ids = OrderUser.chatroom_order_users(params[:id]).ids
      params[:chatroom_order][:ids].each do |id|
        if !order_user_ids.to_s.include?(id)
          OrderUser.create(regional: id, order_id: params[:id])
        end
      end

      @chatroom = ChatroomOrder.find(params[:id])
      format.js
    end
  end

  def load_item_messages
      if params[:order_entry_id].present?
        @order_entry = OrderEntry.find(params[:order_entry_id])
        respond_to do |format|
          @messages = ItemMessage.where(order_entry_id: @order_entry.id)
          @product = Product.find(@order_entry.product_id)

          format.js
        end
      end
  end

  private
      def set_chatroom
        @chatroom = ChatroomOrder.find(params[:chatroom_order_id])
      end

      def chatroom_user_params
        params.require(:chatroom_order).permit( ids: [] )
      end

end
