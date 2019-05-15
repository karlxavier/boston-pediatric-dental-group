class ErrorsController < ApplicationController
     protect_from_forgery with: :null_session

     def not_found
          # render(status: 404)
          render 'errors/not_found'
     end

     def internal_server_error
          # render(status: 500)
          render 'errors/not_found'
     end
end