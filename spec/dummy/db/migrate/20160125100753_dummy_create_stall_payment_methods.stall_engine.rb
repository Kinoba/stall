# This migration comes from stall_engine (originally 20160125100733)
class DummyCreateStallPaymentMethods < ActiveRecord::Migration[4.2][4.2]
  def change
    create_table :stall_payment_methods do |t|
      t.string :name
      t.string :identifier

      t.timestamps null: false
    end
  end
end
