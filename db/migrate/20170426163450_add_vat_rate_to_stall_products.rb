class AddVatRateToStallProducts < ActiveRecord::Migration[4.2]
  def change
    add_column :stall_products, :vat_rate, :decimal, precision: 4, scale: 2
  end
end
