class AddStateToStallAddresses < ActiveRecord::Migration[4.2]
  def change
    add_column :stall_addresses, :state, :string
  end
end
