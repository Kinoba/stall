class AddStateToStallShipments < ActiveRecord::Migration[4.2]
  def change
    add_column :stall_shipments, :state, :integer, default: 0
  end
end
