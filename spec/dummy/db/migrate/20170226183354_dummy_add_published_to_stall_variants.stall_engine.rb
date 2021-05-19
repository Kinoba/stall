# This migration comes from stall_engine (originally 20170226183342)
class DummyAddPublishedToStallVariants < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :stall_variants, :published, :boolean, default: true
  end
end
