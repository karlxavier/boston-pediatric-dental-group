class Admin::PatientSharedFilesController < Admin::BaseController
     before_action :set_shared_file, only: [:edit, :update, :show, :destroy]

     def index
          @shared_files = PatientSharedFile.all
          @patients_with_shares = Patient.patients_with_shared_files
      end
  
      def new
          @shared_file = PatientSharedFile.new
      end
  
     #  def create
     #      @shared_file = PatientSharedFile.new(shared_file_params)
  
     #      respond_to do |format|
     #         if @shared_file.save
     #            format.html { redirect_to admin_patient_shared_files_path }
     #          else
     #              format.html { render 'new' }
     #          end
     #      end
     #  end
  
      def edit
      end
  
      def show
      end
  
     #  def update
     #      respond_to do |format|
     #          if @shared_file.update_attributes(shared_file_params)
     #              format.html { redirect_to admin_patient_shared_files_path }
     #          else
     #              format.html { render 'edit' }
     #          end
     #      end
     #  end
  
      def destroy
          if @shared_file.destroy
              flash.now[:notice] = "Shared file successfully deleted."
          else
              flash.now[:error] = "Cannot delete this file, associations still exist."
          end
          render action: :index
      end

      def shared_files
          respond_to do |format|
               @patient = Patient.find(params[:patient_id])
               format.js
          end
      end
  
      private
  
          def shared_file_params
              params.require(:patient_shared_file).permit(:full_name, :email, :status, :mobile_no, :password, :password_confirmation, :office_id)
          end
  
          def set_shared_file
              @shared_file = PatientSharedFile.find(params[:id])
          end
  
end