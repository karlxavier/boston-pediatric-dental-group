class CreateOrderAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :order_attachments do |t|
      t.integer :order_id
      t.text :attachment_data

      t.timestamps
    end
  end
end
