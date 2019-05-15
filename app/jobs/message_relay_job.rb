class MessageRelayJob < ApplicationJob
  queue_as :default
	  
	def perform(message, current_user)
		ActionCable.server.broadcast "channels:#{message.channel_id}", {
			username: message.user.email,
			message_user_id: message.user.id,
			message: Users::MessagesController.render(message),
			channel_id: message.channel_id,
			chatroom_name: "Channel-#{message.channel_id}"
		}
	end  
end
