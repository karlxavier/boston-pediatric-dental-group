class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:new, :confirm_me, :update, :destroy]
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
    if self.class.to_s.split("::").first === 'Users'
      if current_user.admin?
        @notifications_count =  Audit.admin_unread_count(current_user.front_last_notified, current_user.id)
      else
        @notifications_count =  Audit.user_unread_notifications(current_user.front_last_notified, current_user.id).count
      end
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

  unless Rails.application.config.consider_all_requests_local
    rescue_from ActionController::RoutingError, with: -> { render_404  }
  end

  protected

  # def authenticate_user!
  #   if self.class.to_s.split("::").first === 'Patients'
  #     unless patient_signed_in?
  #       redirect_to( new_patient_session_path, alert: 'Please login to continue')
  #     else
  #       unless current_patient.confirmed?
  #         # sign_out current_patient
  #         redirect_to confirm_me_patients_patients_path
  #       end
  #     end
  #   elsif self.class.to_s.split("::").first === 'Users' || self.class.to_s.split("::").first === 'Admin'
  #     redirect_to new_user_session_path unless user_signed_in?
  #   end
  # end

    def authenticate_user!
    if self.class.to_s.split("::").first === 'Patients'
      if self.class.to_s.split("::").last === 'PasswordsController' && action_name === 'edit'
        # redirect_to new_password_patients_patients_path
      elsif !patient_signed_in?
        redirect_to( new_patient_session_path, alert: 'Please login to continue')
      else
        unless current_patient.confirmed?
          # sign_out current_patient
          redirect_to confirm_me_patients_patients_path
        end
      end
    elsif self.class.to_s.split("::").first === 'Users' || self.class.to_s.split("::").first === 'Admin'
      redirect_to new_user_session_path unless user_signed_in?
    end
  end

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
    # request.env['omniauth.origin'] || stored_location_for(resource) || resource_name === 'patient' ? users_root_path : patients_root_path
    if resource_name == :patient
      patients_root_path 
    elsif resource_name == :user
      users_user_time_logs_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
      new_user_session_path
    elsif resource_or_scope == :patient
      new_patient_session_path
    else
      root_path
    end
  end
  
end
