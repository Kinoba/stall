# This migration comes from stall_engine (originally 20160307142924)
class DummyAddStateToStallAddresses < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :stall_addresses, :state, :string
  end
end
