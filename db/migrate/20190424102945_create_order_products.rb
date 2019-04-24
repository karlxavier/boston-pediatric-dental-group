class CreateOrderProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :order_products do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :quantity
      t.decimal :amount
      t.decimal :net_amount

      t.timestamps
    end
  end
end
