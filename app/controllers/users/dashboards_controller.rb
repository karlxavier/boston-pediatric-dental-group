class Users::DashboardsController < ApplicationController
    
    def index
        @filter_date = params[:filter].present? ? params[:filter][:time_ind] : Time.now
        @timelogs = UserTimeLog.dashboard_latest_logs(DateTime.parse(@filter_date.to_s).to_date)
    end

    def show
        timelog = UserTimeLog.find(params[:id])
        @user_timelogs = UserTimeLog.user_time_log(timelog.time_in, timelog.user_id)

        respond_to do |format|
            format.js
        end
    end
end
  