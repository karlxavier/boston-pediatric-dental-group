class AddColumnToVendor < ActiveRecord::Migration[5.1]
  def change
    add_column :vendors, :active, :boolean, default: true
  end
end
