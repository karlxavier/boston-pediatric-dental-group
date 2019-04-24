class OrderAttachment < ApplicationRecord
     belongs_to :order

     include AttachmentUploader[:attachment]
end
