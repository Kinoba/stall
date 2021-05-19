class AddIdentifierToStallProductLists < ActiveRecord::Migration[4.2]
  def change
    add_column :stall_product_lists, :identifier, :string, null: false, default: 'default'
  end
end
