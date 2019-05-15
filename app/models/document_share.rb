class DocumentShare < ApplicationRecord
    belongs_to :user
    belongs_to :patient
    belongs_to :document_upload

    scope :patient_roots, -> (patient_id) { includes(:document_upload).where( patient_id: patient_id, document_uploads: {document_upload_id: nil} ) }
end
