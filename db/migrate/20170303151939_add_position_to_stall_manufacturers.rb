class AddPositionToStallManufacturers < ActiveRecord::Migration[4.2]
  def change
    add_column :stall_manufacturers, :position, :integer, default: 0
  end
end
