class RemoveImageAttachmentToStallProducts < ActiveRecord::Migration[4.2]
  def change
    remove_attachment :stall_products, :image
  end
end
