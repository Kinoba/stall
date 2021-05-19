class CreateStallCuratedProductLists < ActiveRecord::Migration[4.2]
  def change
    create_table :stall_curated_product_lists do |t|
      t.string :name
      t.string :slug

      t.timestamps null: false
    end
  end
end
