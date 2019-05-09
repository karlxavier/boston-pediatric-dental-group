class CreateInventoryDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :inventory_details do |t|
      t.integer :inventory_id
      t.integer :order_id

      t.timestamps
    end
  end
end
