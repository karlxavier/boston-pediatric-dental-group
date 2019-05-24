class Admin::DocumentUploadsController < Admin::BaseController
    before_action :set_document, only: [:edit, :update, :show]

    def index
        # @document_uploads = DocumentUpload.all
        @roots = DocumentUpload.roots
    end

    def new
        @document_upload = DocumentUpload.new
    end

    def create

        respond_to do |format|
            if params[:document_upload].has_key?(:attachment)
                params[:document_upload][:attachment].each do |file|
                    @document_upload = DocumentUpload.new(doc_params)
                    @document_upload.attachment = file
                    @document_upload.save
                    flash.now[:notice] = "File successfully created."
                end
            else
                @document_upload = DocumentUpload.new(doc_params)
                @document_upload.save
            end
            format.html { redirect_to admin_document_uploads_path }
        end 
    end

    def edit
    end

    def show
        @parents = @document_upload.get_parents
        respond_to do |format|
            format.js
        end
    end

    def update
        respond_to do |format|
            if @document_upload.update_attributes(doc_params)
                flash.now[:notice] = "File successfully updated."
                format.html { redirect_to admin_document_uploads_path }
            else
                format.html { render 'edit' }
            end
        end
    end

    def new_folder_root
        respond_to do |format|
            format.js
        end
    end

    def new_folder_sub
        # @parent_document = DocumentUpload.find(params[:document_upload_id]).subs.new
        @parent = DocumentUpload.find(params[:document_upload_id])
        respond_to do |format|
            format.js
        end
    end

    def upload_files
        if params[:document_upload_id] != '0'
            @parent = DocumentUpload.find(params[:document_upload_id])
        end
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

    def edit_folder
        @document_upload = DocumentUpload.find(params[:document_upload_id])
        respond_to do |format|
            format.js
        end
    end

    def share_file
        @document_upload = DocumentUpload.find(params[:document_upload_id])
        respond_to do |format|
            format.js
        end
    end

    private

        def doc_params
            params.require(:document_upload).permit(:description, :attachment, :document_upload_id, user_ids: [], patient_ids: [])
        end

        def set_document
            @document_upload = DocumentUpload.find(params[:id])
        end
    

end
