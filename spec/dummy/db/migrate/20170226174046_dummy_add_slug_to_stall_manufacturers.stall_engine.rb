# This migration comes from stall_engine (originally 20170221094450)
class DummyAddSlugToStallManufacturers < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :stall_manufacturers, :slug, :text
  end
end
