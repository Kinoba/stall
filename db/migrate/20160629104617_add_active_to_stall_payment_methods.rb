class AddActiveToStallPaymentMethods < ActiveRecord::Migration[4.2]
  def up
    add_column :stall_payment_methods, :active, :boolean, default: true

    PaymentMethod.update_all(active: true)
  end

  def down
    remove_column :stall_payment_methods, :active
  end
end
