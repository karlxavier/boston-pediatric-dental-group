class Admin::PatientsController < Admin::BaseController
     before_action :set_patient, only: [:edit, :update, :show, :destroy]

     def index
          @patients = Patient.all
      end
  
      def new
          @patient = Patient.new
      end
  
      def create
          @patient = Patient.new(patient_params)
  
          respond_to do |format|
             if @patient.save
                # PatientMailer.welcome_mail(@patient).deliver
                @patient.send_reset_password_instructions
                format.html { redirect_to admin_patients_path }
              else
                  format.html { render 'new' }
              end
          end
      end
  
      def edit
      end
  
      def show
      end
  
      def update
          respond_to do |format|
              if @patient.update_attributes(patient_params)
                  format.html { redirect_to admin_patients_path }
              else
                  format.html { render 'edit' }
              end
          end
      end
  
      def destroy
          if @patient.destroy
              flash.now[:notice] = "Patient #{@patient.full_name} successfully deleted."
          else
              flash.now[:error] = "Cannot delete this patient, associations still exist."
          end
          render action: :index
      end
  
      private
  
          def patient_params
              params.require(:patient).permit(:full_name, :email, :status, :mobile_no, :password, :password_confirmation, :office_id)
          end
  
          def set_patient
              @patient = Patient.find(params[:id])
          end
  
end