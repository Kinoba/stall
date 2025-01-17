# This migration comes from stall_engine (originally 20170202165518)
class DummyCreateStallVariantPropertyValues < ActiveRecord::Migration[4.2][4.2]
  def change
    create_table :stall_variant_property_values do |t|
      t.references :property_value, index: true
      t.references :variant, index: true

      t.timestamps null: false
    end

    add_foreign_key :stall_variant_property_values, :stall_property_values, column: :property_value_id
    add_foreign_key :stall_variant_property_values, :stall_variants, column: :variant_id
  end
end
