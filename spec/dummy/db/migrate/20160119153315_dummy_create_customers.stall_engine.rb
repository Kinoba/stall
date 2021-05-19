# This migration comes from stall_engine (originally 20160118124016)
class DummyCreateCustomers < ActiveRecord::Migration[4.2][4.2]
  def change
    create_table :stall_customers do |t|
      t.string :email

      t.timestamps null: false
    end

    add_foreign_key :stall_product_lists, :stall_customers, column: :customer_id
  end
end
