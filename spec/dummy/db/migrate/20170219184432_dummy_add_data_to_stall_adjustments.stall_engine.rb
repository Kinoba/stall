# This migration comes from stall_engine (originally 20170131162537)
class DummyAddDataToStallAdjustments < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :stall_adjustments, :data, :jsonb
  end
end
