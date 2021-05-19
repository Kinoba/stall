# This migration comes from stall_engine (originally 20160317141632)
class DummyAddStateToStallShipments < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :stall_shipments, :state, :integer, default: 0
  end
end
