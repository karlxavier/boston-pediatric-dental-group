class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    drop_table :orders, force: :cascade
    create_table :orders do |t|
      t.integer :user_id
      t.string :notes
      t.integer :supplier_id
      t.decimal :total_amount
      t.integer :status
      t.string :invoice_number
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
