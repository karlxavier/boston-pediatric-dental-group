class AddHotelToOrderBranch < ActiveRecord::Migration[5.1]
  def change
    add_column :order_branches, :hotel_id, :integer
  end
end
