class CreateOrderOffices < ActiveRecord::Migration[5.1]
  def change
    create_table :order_offices do |t|
      t.integer :order_id
      t.integer :office_id

      t.timestamps
    end
  end
end
