class DocumentUpload < ApplicationRecord
    audited
    
    has_many :document_shares
    has_many :users, through: :document_shares
    has_many :patients, through: :document_shares

    # belongs_to :parent, class_name: 'DocumentUpload', optional: true, foreign_key: :document_upload_id
    # has_many :subs, class_name: 'DocumentUpload', dependent: :destroy

    has_many :subs, class_name: 'DocumentUpload', dependent: :destroy
    belongs_to :parent, class_name: 'DocumentUpload', optional: true, foreign_key: :document_upload_id

    # has_many :subs, class_name: 'DocumentUpload', foreign_key: :document_upload_id
    # belongs_to :parent, class_name: 'DocumentUpload', foreign_key: :document_upload_id

    scope :roots, -> { where(document_upload_id: nil) }

    include AttachmentUploader[:attachment]

    enum status: [:active, :deleted]

    def self.tree_data
        output = []
        DocumentUpload.roots.each do |docs|
          output << data(docs)
        end
        output
    end

    def get_parents(result = [])
        if self.parent.present?
          result.push(self.parent)
          self.parent.get_parents(result)
        else
            # result.push(self) if result.blank?
            return result
        end
    end
      
    
    def self.data(docs)
        subordinates = []
        unless docs.subs.blank?
          docs.subs.each do |doc|
            subordinates << data(doc)
          end
        end
        {name: docs.description, subordinates: subordinates}
    end

end
