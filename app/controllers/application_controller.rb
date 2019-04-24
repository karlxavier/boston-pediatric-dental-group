class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :user_notification_count 
  helper_method :front_notification_count 
  helper_method :user_notifications 
  helper_method :front_unread_notifications

  def user_notification_count
    @notifications_count = Audit.unread_count(current_user.last_notified)
  end

  def front_notification_count
    if current_user.admin?
      @notifications_count =  Audit.admin_unread_count(current_user.front_last_notified, current_user.id)
    else
      @notifications_count =  Audit.user_unread_notifications(current_user.front_last_notified, current_user.id).count
    end
  end

  def front_unread_notifications
    if current_user.admin?
      @notifications =  Audit.admin_unread_notifications(current_user.front_last_notified, current_user.id)
    else
      @notifications =  Audit.user_unread_notifications(current_user.front_last_notified, current_user.id)
    end
  end

  def user_notifications
    if current_user.admin?
      Audit.admin_unread_notifications(current_user.front_last_notified, current_user.id)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:password, :password_confirmation, roles: []])
  end

  def authenticate_current_user
    head :unauthorized if get_current_user.nil?
  end

  def get_current_user
    return nil unless cookies[:auth_headers]
    auth_headers = JSON.parse(cookies[:auth_headers])

    expiration_datetime = DateTime.strptime(auth_headers["expiry"], "%s")
    current_user = User.find_by(uid: auth_headers["uid"])

    if current_user &&
        current_user.tokens.has_key?(auth_headers["client"]) &&
        expiration_datetime > DateTime.now

      @current_user = current_user
    end
    @current_user
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || orders_path
  end

  # def authenticate_user!
  #   if user_signed_in?
  #     super
  #   else
  #     redirect_to new_user_session_path
  #   end
  # end
  
end
