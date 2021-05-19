# This migration comes from stall_engine (originally 20170206091211)
class DummyAddNameToStallVariants < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :stall_variants, :name, :string
  end
end
