class AddUserToCustomer < ActiveRecord::Migration[4.2]
  def change
    add_reference :stall_customers, :user, polymorphic: true, index: true
  end
end
