class FixCuratedProductListBadForeignKey < ActiveRecord::Migration[4.2]
  def change
    remove_foreign_key :stall_curated_list_products, column: :curated_product_list_id
    add_foreign_key :stall_curated_list_products, :stall_curated_product_lists, column: :curated_product_list_id
  end
end
