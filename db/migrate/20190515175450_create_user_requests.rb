class CreateUserRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :user_requests do |t|
      t.integer :user_id
      t.boolean :is_approve, default: false
      t.string :remarks
      t.integer :request_type
      t.integer :user_time_log_id
      t.datetime :date
      t.boolean :executed, default: false
      t.datetime :time_in
      t.datetime :time_out
      t.string :description

      t.timestamps
    end
  end
end
