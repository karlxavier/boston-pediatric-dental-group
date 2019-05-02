class AddColumnVcCodeToOrderProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :order_products, :vc_code, :string
    add_column :order_products, :mfg_code, :string
  end
end
