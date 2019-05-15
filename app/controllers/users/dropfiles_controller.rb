class Users::DropfilesController < ApplicationController
  skip_before_action :verify_authenticity_token
	# before_action :authenticate_user!
	before_action :set_chatroom

	def create
    message = @chatroom.messages.create(body: '', attachment: file, user: current_user)
		MessageRelayJob.perform_later(message, current_user.id)
	rescue => e
		render json: {
			error: "File type not supported/ File is larger than 2mb",
			original_error: e.message
		}, status: :unprocessable_entity
	end

	private

	def set_chatroom
		@chatroom = ChatroomOrder.find(params[:chatroom_order_id])
    end
    
    def file
      params[:file]
    end
end