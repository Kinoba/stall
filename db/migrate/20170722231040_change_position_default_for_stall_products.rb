class ChangePositionDefaultForStallProducts < ActiveRecord::Migration[4.2]
  def up
    change_column_default :stall_products, :position, 0
  end

  def down
    change_column_default :stall_products, :position, nil
  end
end
