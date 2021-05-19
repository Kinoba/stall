class AddNameToStallVariants < ActiveRecord::Migration[4.2]
  def change
    add_column :stall_variants, :name, :string
  end
end
