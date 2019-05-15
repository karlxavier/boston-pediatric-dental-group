class Users::StaticPagesController < ApplicationController

  def dashboard
    #puts "#{User.find(current_user.id).to_json}"
  end
end
