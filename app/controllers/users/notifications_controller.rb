class Users::NotificationsController < ApplicationController

	def index
		if current_user.admin?
			@audits = Audit.admin_all_notifications.limit(100)
		else
			@audits = Audit.user_all_notifications(current_user.id).limit(100)
		end
		current_user.update_attributes(front_last_notified: Time.zone.now)
	end

	def load_notifications
		respond_to do |format|
			format.js
		end
	end

end