class AddSlugToStallManufacturers < ActiveRecord::Migration[4.2]
  def change
    add_column :stall_manufacturers, :slug, :text
  end
end
