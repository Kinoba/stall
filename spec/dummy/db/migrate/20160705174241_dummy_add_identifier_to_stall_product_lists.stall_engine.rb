# This migration comes from stall_engine (originally 20160309165136)
class DummyAddIdentifierToStallProductLists < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :stall_product_lists, :identifier, :string, null: false, default: 'default'
  end
end
