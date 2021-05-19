class AddDataToStallShipments < ActiveRecord::Migration[4.2]
  def change
    add_column :stall_shipments, :data, :jsonb
  end
end
