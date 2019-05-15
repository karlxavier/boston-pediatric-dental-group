class Users::UsersController < ApplicationController

    def edit
        @user = current_user
    end

    def update
        @user = current_user
        if @user.update_attributes(user_params)
            redirect_to authenticated_root_path
        else
            render 'edit'
        end
    end

    private

        def user_params
            params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :users_group_id)
        end

end
  