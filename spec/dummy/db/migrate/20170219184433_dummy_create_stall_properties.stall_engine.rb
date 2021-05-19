# This migration comes from stall_engine (originally 20170202165514)
class DummyCreateStallProperties < ActiveRecord::Migration[4.2][4.2]
  def change
    create_table :stall_properties do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
