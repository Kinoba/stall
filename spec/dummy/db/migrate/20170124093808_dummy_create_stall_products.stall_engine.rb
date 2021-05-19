# This migration comes from stall_engine (originally 20170123123326)
class DummyCreateStallProducts < ActiveRecord::Migration[4.2][4.2]
  def change
    create_table :stall_products do |t|
      t.string :name
      t.attachment :image
      t.text :description
      t.text :slug
      t.integer :position
      t.boolean :visible
      t.references :product_category, index: true

      t.timestamps null: false
    end

    add_foreign_key :stall_products, :stall_product_categories, column: 'product_category_id'
  end
end
