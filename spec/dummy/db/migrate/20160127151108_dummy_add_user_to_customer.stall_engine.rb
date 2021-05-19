# This migration comes from stall_engine (originally 20160127113619)
class DummyAddUserToCustomer < ActiveRecord::Migration[4.2][4.2]
  def change
    add_reference :stall_customers, :user, polymorphic: true, index: true
  end
end
