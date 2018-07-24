class MessagesController < ApplicationController
skip_before_action :verify_authenticity_token
before_action :authenticate_user!
before_action :set_chatroom, except: [:edit, :update]
before_action :set_message_edit, only: [:edit, :update]

	def create
		message = @chatroom.messages.new(message_params)
		message.user = current_user
		
		message.save
		MessageRelayJob.perform_later(message, current_user)
	end

	def show
		if current_user.admin?
	    	@chatroom_orders = ChatroomOrder.order(id: :desc)
	    else
	    	@chatroom_orders = ChatroomOrder.only_my_chatrooms(current_user.id).order(id: :desc)
	    end
	end

	def edit
		@chatroom = ChatroomOrder.find(@message.chatroom_order_id)
	end

	def update
		@message.update_attributes(message_params)
		respond_to do |format|
			format.js
		end
	end

	private

		def message_params
			params.require(:message).permit(:body, :attachment)
		end

		def set_chatroom
			@chatroom = ChatroomOrder.find(params[:chatroom_order_id])
		end

		def set_message_edit			
			@message = Message.find(params[:id])
		end
end
