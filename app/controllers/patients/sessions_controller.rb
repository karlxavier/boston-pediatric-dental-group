class Patients::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # def create
  #   self.resource = warden.authenticate!(auth_options)
  #   set_flash_message(:notice, :signed_in) if is_navigational_format?
  #   sign_in(resource_name, resource)
    
  #   unless resource.confirmed?
  #     # redirect_to session[:return_to]
  #     # session[:return_to] = nil
  #     # render :js => "window.location = '/patients/sessions/create'"
  #     respond_to do |format|
  #       format.js
  #     end
  #   else
  #     respond_with resource, :location => after_sign_in_path_for(resource)
  #   end
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private

  def requires_confirmation?
    if patient.confirmed?
      false
    else
      true
    end
  end

  def redirect_url
    unless current_patient.confirmed?
      # custom_redirect_path
      puts '*********** redirect_url'
    else
      puts '*********** super'
      super
    end
  end

end
