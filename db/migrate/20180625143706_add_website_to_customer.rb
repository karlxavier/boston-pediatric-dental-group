class AddWebsiteToCustomer < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :website, :string
  end
end
