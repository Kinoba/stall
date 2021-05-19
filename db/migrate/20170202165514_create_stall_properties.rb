class CreateStallProperties < ActiveRecord::Migration[4.2]
  def change
    create_table :stall_properties do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
