class CreateStallPaymentMethods < ActiveRecord::Migration[4.2]
  def change
    create_table :stall_payment_methods do |t|
      t.string :name
      t.string :identifier

      t.timestamps null: false
    end
  end
end
