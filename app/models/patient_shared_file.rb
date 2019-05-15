class PatientSharedFile < ApplicationRecord
     belongs_to :patient

     validates :attachment_data, presence: true

     include AttachmentUploader[:attachment]
end
