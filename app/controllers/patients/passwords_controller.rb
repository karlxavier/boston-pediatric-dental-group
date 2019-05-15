# frozen_string_literal: true

class Patients::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  def edit
    digest_token = Devise.token_generator.digest(self, :reset_password_token, params[:reset_password_token])
    @confirm_patient = Patient.where(reset_password_token: digest_token)
    # self.resource = resource_class.new
    # resource.reset_password_token = params[:reset_password_token]
    super
  end

  # PUT /resource/password
  def update
    digest_token = Devise.token_generator.digest(self, :reset_password_token, params[:patient][:reset_password_token])
    @patient = Patient.where(reset_password_token: digest_token).first

    if @patient.present?
      if @patient.update_attributes(password_params)
        sign_in(@patient, bypass: true)
        redirect_to patients_root_path
      else
        render :edit
      end
    end
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

    private

    def password_params
      params.require(:patient).permit(:id, :password, :password_confirmation, :reset_password_token)
    end
end
