class Patients::DocumentUploadsController < ApplicationController
     before_action :set_document, only: [:show]

     def index
          @roots = DocumentShare.patient_roots(current_patient.id)
     end

     def show
          @parents = @document_upload.get_parents
          respond_to do |format|
              format.js
          end
     end

     def doc_preview
          @document = DocumentUpload.find(params[:document_upload_id])
          respond_to do |format|
              format.js
          end
     end

     private

     def set_document
          @document_upload = DocumentUpload.find(params[:id])
     end

end