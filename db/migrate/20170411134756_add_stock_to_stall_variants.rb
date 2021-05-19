class AddStockToStallVariants < ActiveRecord::Migration[4.2]
  def change
    add_column :stall_variants, :stock, :integer, default: 0
  end
end
