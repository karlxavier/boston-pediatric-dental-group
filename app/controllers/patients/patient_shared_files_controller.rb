class Patients::PatientSharedFilesController < ApplicationController

     def index
          @shared_files = current_patient.patient_shared_files.order(created_at: :desc)
     end

     def new
          respond_to do |format|
              format.js
          end
     end

     def create
          # Dropzone will send each file inside of the `:file` param.
          @picture = current_patient.patient_shared_files.create(attachment: params[:file])
          
          # Return a json response of the partial `_picture.html.erb` so Dropzone can append the uploaded image to the dom if the `@picture` object was successfully created.
          if @picture
               # Reuse existing partial
               picture_partial = render_to_string(
                    'patients/patient_shared_files/_picture',
                    layout: false,
                    formats: [:html],
                    locals: { picture: @picture }
               )
               @shared_files = current_patient.patient_shared_files.order(created_at: :desc)
               render json: { picture: picture_partial }, status: 200

          else
               render json: @picture.errors, status: 400
          end
     end

     def show
          # @parents = @document_upload.get_parents
          # respond_to do |format|
          #     format.js
          # end
     end

     def doc_preview
          # @document = DocumentUpload.find(params[:document_upload_id])
          # respond_to do |format|
          #     format.js
          # end
     end

     private

          def doc_params
               params.require(:document_upload).permit(:notes, :attachment)
          end


end