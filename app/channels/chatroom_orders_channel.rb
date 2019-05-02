class ChatroomOrdersChannel < ApplicationCable::Channel
  	def subscribed
		# if current_user.admin?
		# 	Channel.all.each do |channel|	
		# 		stream_from "channels:#{channel.id}"
		#   	end
		# else
		# 	Channel.user_broadcast_channels(current_user.id).each do |channel|
		# 		stream_from "channels:#{channel.channel_id}"
		#   	end
	  	# end
  	end

  	def unsubscribed
    		stop_all_streams
  	end
end
