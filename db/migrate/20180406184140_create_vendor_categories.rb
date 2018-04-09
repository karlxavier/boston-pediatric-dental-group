class CreateVendorCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :vendor_categories do |t|
      t.integer :vendor_id
      t.integer :category_id

      t.timestamps
    end
  end
end
