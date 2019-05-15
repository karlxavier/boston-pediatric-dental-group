class Users::UserRequestsController < ApplicationController

     def new
          @user_request = UserRequest.new

          respond_to do |format|
               format.js
          end
     end

     def create
          @request = current_user.user_requests.new(request_params)
          respond_to do |format|
               if @request.save
                    @user_requests = current_user.user_requests.where(executed: false).all

                    format.js
               end
          end
     end

     def request_timelog_update
          @user_request = UserRequest.new
          @timelog = UserTimeLog.find(params[:timelog_id])
          respond_to do |format|
               format.js
          end
     end

     def execute_new_timelog
          @request_id = params[:request_id]
          respond_to do |format|
               format.js
          end
     end

     def execute_edit_timelog
          @user_time_log = UserRequest.find(params[:request_id]).user_time_log
          @request_id = params[:request_id]
          respond_to do |format|
               format.js
          end
     end

     private

          def request_params
               params.require(:user_request).permit(:date, :request_type, :remarks, :user_time_log_id, :time_in, :time_out, :description)
          end

end