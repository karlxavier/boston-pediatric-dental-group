class CreatePatientSharedFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :patient_shared_files do |t|
      t.integer :patient_id
      t.text :attachment_data
      t.string :notes_string

      t.timestamps
    end
  end
end
