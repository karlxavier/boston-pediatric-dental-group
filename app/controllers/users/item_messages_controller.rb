class Users::ItemMessagesController < ApplicationController
skip_before_action :verify_authenticity_token
# before_action :authenticate_user!
before_action :set_item

def create
	message = @order_entry.item_messages.new(message_params)
	message.user = current_user
	
	message.save
	ItemMessageJob.perform_later(message, current_user, @order_entry.product_id)

	if message.errors.any?
	    message.errors.full_messages.each do |message|
	    	puts '******** message ERRORS ********'
	    	puts message
	    end
	end
end

private

	def message_params
		params.require(:item_message).permit(:body, :attachment, :order_entry_id)
	end

	def set_item
		if params[:order_entry_id].present?
			@order_entry = OrderEntry.find(params[:order_entry_id])
			# @item = Product.find(order_entry.product_id)
		end
	end
end
