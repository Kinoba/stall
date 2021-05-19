class CreateStallProductCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :stall_product_categories do |t|
      t.string :name
      t.text :slug
      t.integer :position, default: 0
      t.integer :parent_id

      t.timestamps null: false
    end
  end
end
