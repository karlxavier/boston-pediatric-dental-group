namespace :app_schedule do
  desc "TODO"
  task check_if_user_logout: :environment do

    puts '********** CHECK IF USER LOGOUT! ***********'
    UserTimeLog.where(active: true).each do |active_login|

      if active_login.user.mobile.present?
        
        twilio_number = ENV['TWILIO_NUMBER']
        sms = "BostonPDG :: Hi #{active_login.user.full_name} YOU NEED TO LOGOUT! on #{active_login.time_in.strftime("%A %b %d, %C %I:%M %P")}"

        @client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
        message = @client.messages.create(
          body: sms,
          from: twilio_number,
          to: active_login.user.mobile
        )

        puts message.sid
      end
    end
  end

end
