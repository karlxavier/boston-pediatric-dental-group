class Admin::UserRequestsController < Admin::BaseController

     def index
          @user_requests = UserRequest.all
     end

     def update
        @request = UserRequest.find(params[:id])
        @request.update_attributes(is_approve: true)

        @timelog = UserTimeLog.find(@request.user_time_log_id)

        request_date = DateTime.parse(params[:user_request][:date]).strftime("%Y-%m-%d")
        time_in = [request_date, params[:user_request][:time_in]].join(' ')
        time_out = [request_date, params[:user_request][:time_out]].join(' ')

        @timelog.description = params[:user_request][:description]
        @timelog.time_in = Time.parse(time_in)
        @timelog.time_out = Time.parse(time_out)
        @timelog.duration = (Time.parse(time_out) - Time.parse(time_in)).to_i
        @timelog.active = false

        respond_to do |format|
            if @timelog.save
                @user_requests = UserRequest.all
                format.js
            end
        end

     end

     def approve_request
        @user_request = UserRequest.find(params[:user_request_id])
        respond_to do |format|
            format.js
        end
     end

     def destroy
          @request = UserRequest.find(params[:id])
          @user_requests = UserRequest.all
          if @request.destroy
              flash.now[:notice] = "User request successfully deleted."
          else
              flash.now[:error] = "Cannot delete this user request, associations still exist."
          end
          render action: :index
    end

    private

        def user_request_params
            params.require(:user_request).permit(:date, :description, :time_in, :time_out, :is_approve)
        end

end