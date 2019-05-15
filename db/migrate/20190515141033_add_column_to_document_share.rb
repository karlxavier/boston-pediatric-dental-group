class AddColumnToDocumentShare < ActiveRecord::Migration[5.1]
  def change
    add_column :document_shares, :patient_id, :integer
  end
end
