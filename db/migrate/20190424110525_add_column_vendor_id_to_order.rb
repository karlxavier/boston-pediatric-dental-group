class AddColumnVendorIdToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :vendor_id, :integer
  end
end
