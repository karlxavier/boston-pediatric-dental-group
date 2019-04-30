class AddColumnVendorCodeToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :vendor_code, :string
  end
end
