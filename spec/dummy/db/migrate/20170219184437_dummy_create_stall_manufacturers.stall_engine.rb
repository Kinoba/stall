# This migration comes from stall_engine (originally 20170217142050)
class DummyCreateStallManufacturers < ActiveRecord::Migration[4.2][4.2]
  def change
    create_table :stall_manufacturers do |t|
      t.string :name
      t.attachment :logo

      t.timestamps null: false
    end
  end
end
