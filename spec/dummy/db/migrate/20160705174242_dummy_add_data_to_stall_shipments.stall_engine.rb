# This migration comes from stall_engine (originally 20160316114649)
class DummyAddDataToStallShipments < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :stall_shipments, :data, :jsonb
  end
end
