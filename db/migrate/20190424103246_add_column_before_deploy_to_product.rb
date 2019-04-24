class AddColumnBeforeDeployToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :vc_code, :string
    add_column :products, :mfg_code, :string
    add_column :products, :category_id, :integer
    add_column :order_products, :status, :integer, default: 0
    add_column :order_products, :received_on, :datetime
  end
end
