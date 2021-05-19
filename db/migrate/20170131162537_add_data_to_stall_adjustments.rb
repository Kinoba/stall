class AddDataToStallAdjustments < ActiveRecord::Migration[4.2]
  def change
    add_column :stall_adjustments, :data, :jsonb
  end
end
