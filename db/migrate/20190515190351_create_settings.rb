class CreateSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings do |t|
      t.string :default_country_code

      t.timestamps
    end
  end
end
