class UserRequest < ApplicationRecord
     belongs_to :user
     belongs_to :user_time_log

     enum request_type: [:edit_request, :add_request]
end
