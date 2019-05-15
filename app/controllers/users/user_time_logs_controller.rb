class Users::UserTimeLogsController < ApplicationController
    autocomplete :default_work, :description, full: true
    # before_action :set_user_time_log, only: [:index, :get_start_second]

    def index
        @time_logs = UserTimeLog.group_logs(current_user.id)
        @time_log = UserTimeLog.get_active_time_in(current_user.id).first
        if @time_log.present?
            @start_time = (Time.zone.now - @time_log.time_in).to_i
        end
    end

    def create
        @time_log = UserTimeLog.new
        @time_log.time_in = Time.zone.now
        @time_log.user = current_user
        @time_log.description = params[:user_time_log][:description]

        respond_to do |format|
            if @time_log.save
                # @start_time = (Time.zone.now - @time_log.time_in).to_i

                format.js
            end
        end
    end

    def update
        @time_log = UserTimeLog.get_active_time_in(current_user.id).first
        @time_log.time_out = Time.zone.now
        @time_log.user = current_user
        @time_log.active = false
        @time_log.duration = (Time.zone.now - @time_log.time_in).to_i

        respond_to do |format|
            if @time_log.save
                @start_time = (Time.zone.now - @time_log.time_in).to_i
                @time_logs = UserTimeLog.group_logs(current_user.id)
                
                format.js
            end
        end
    end

    def get_start_second
        @time_log = UserTimeLog.get_active_time_in(current_user.id).first
        if @time_log.present?
            render json: { status: 'success', start_at: (Time.zone.now - @time_log.time_in).to_i}, status: :ok
        else
            render json: { status: 'error', message: 'cannot find user' }, status: 400
        end
    end

    def timelog_report
        if params[:filter].present?
            @timelog_report = UserTimeLog.user_filter_timelogs(current_user.id,DateTime.parse(params[:filter][:from_date].to_s).to_date, DateTime.parse(params[:filter][:to_date].to_s).to_date)
        else
            @timelog_report = current_user.user_time_logs
        end
    end

    def execute_create_timelog
        @timelog = current_user.user_time_logs.new

        time_in = [params[:user_time_log][:created_at], params[:user_time_log][:time_in]].join(' ')
        time_out = [params[:user_time_log][:created_at], params[:user_time_log][:time_out]].join(' ')

        @timelog.description = params[:user_time_log][:description]
        @timelog.time_in = Time.parse(time_in)
        @timelog.time_out = Time.parse(time_out)
        @timelog.duration = (Time.parse(time_out) - Time.parse(time_in)).to_i
        @timelog.active = false

        respond_to do |format|
            if @timelog.save
                user_request = UserRequest.where(id: params[:user_time_log][:request_id]).first
                user_request.executed = true
                user_request.save

                @user_requests = current_user.user_requests.where(executed: false).all

                format.js { render :file => "/users/user_requests/execute_create_timelog.js.erb" }
            end
        end
    end

    def execute_update_timelog
        puts '**************** execute_update_timelog'
        respond_to do |format|
            format.js
        end
    end

    private

        def timelog_params
            params.require(:user_time_log).permit(:time_in, :time_out, :description, :created_at, :request_id)
        end

        def set_user_time_log
            @time_log = UserTimeLog.get_active_time_in(current_user.id).first
        end

end
  