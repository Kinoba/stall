# This migration comes from stall_engine (originally 20170217143037)
class DummyAddManufacturerToStallProducts < ActiveRecord::Migration[4.2][4.2]
  def change
    add_reference :stall_products, :manufacturer, index: true
    add_foreign_key :stall_products, :stall_manufacturers, column: :manufacturer_id
  end
end
