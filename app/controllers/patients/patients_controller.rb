class Patients::PatientsController < ApplicationController
     before_action :check_if_confirmed

     def confirm_me
          @patient = Patient.find(current_patient.id)
     end

     def update
          @patient = current_patient
          if params[:patient].has_key?(:token)
               token = params[:patient][:token]
               respond_to do |format|
                    @patient = current_patient
                    token = Authy::API.verify(id: @patient.authy_id, token: token)

                    if token.ok?
                         @patient.update(confirmed: true)
                         
                         format.js { render action: "patient_confirmed" }
                    else
                         flash.now[:mobile_errors] = "Invalid token number, please try again."
                         format.js { render action: "invalid_mobile" }
                    end
               end
          else
               mobile_no = params[:patient].has_key?(:mobile_no) ? params[:patient][:mobile_no] : ''
               country_code = Setting.first.default_country_code
               respond_to do |format|
                    if valid?(country_code + mobile_no)
                         authy = Authy::API.register_user(
                              email: @patient.email,
                              cellphone: mobile_no,
                              country_code: country_code
                         )
                         if authy.ok?
                              @patient.update(authy_id: authy.id, mobile_no: mobile_no)
                              Authy::API.request_sms(id: @patient.authy_id)
                              format.js { render action: "valid_mobile" }
                         else
                              flash.now[:mobile_errors] = "Authy API error. Please contact Administrator."
                              format.js { render action: "invalid_mobile" }
                         end
                    else
                         flash.now[:mobile_errors] = "You entered an invalid mobile number."
                         format.js { render action: "invalid_mobile" }
                    end
               end
          end
     end

     def invalid_mobile
     end

     def patient_confirmed
     end
     
    def send_message(message)
          @user = current_user
          twilio_number = ENV['TWILIO_NUMBER']
          @client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_TOKEN']
          message = @client.account.messages.create(
            :from => twilio_number,
            :to => @user.mobile_no,
            :body => message
          )
          puts message.to
    end
 
    def valid?(phone_number)
          @lookup_client = Twilio::REST::Client.new(ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"])
          phone_number = @lookup_client.lookups.phone_numbers(phone_number)
               begin
                    response = phone_number.fetch
                    response.phone_number #if invalid, throws an exception. If valid, no problems.
               return true
           rescue Twilio::REST::RestError => e
               if e.code == 20404
                    return false
               else
                    raise e
               end
               puts "************* VALID? ERROR"
               puts e
           end
     end

     private

          def check_if_confirmed
               if current_patient.confirmed?
                    redirect_to patients_root_path
               end
          end

end