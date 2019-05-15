class Users::DocumentUploadsController < ApplicationController

    def index
        @documents = current_user.document_uploads.order(created_at: :desc)
    end

    def show
        @document = DocumentUpload.find(params[:id])
        respond_to do |format|
            format.js
        end
    end

end
  