# This migration comes from stall_engine (originally 20170123131748)
class DummyCreateStallProductCategoryHierarchies < ActiveRecord::Migration[4.2][4.2]
  def change
    create_table :stall_product_category_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :stall_product_category_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "stall_product_category_anc_desc_idx"

    add_index :stall_product_category_hierarchies, [:descendant_id],
      name: "stall_product_category_desc_idx"
  end
end
