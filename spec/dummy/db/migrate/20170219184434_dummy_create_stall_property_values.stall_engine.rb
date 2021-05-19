# This migration comes from stall_engine (originally 20170202165516)
class DummyCreateStallPropertyValues < ActiveRecord::Migration[4.2][4.2]
  def change
    create_table :stall_property_values do |t|
      t.references :property, index: true
      t.string :value
      t.integer :position, default: 0

      t.timestamps null: false
    end

    add_foreign_key :stall_property_values, :stall_properties, column: :property_id
  end
end
