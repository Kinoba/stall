class CreateStallImages < ActiveRecord::Migration[4.2]
  def change
    create_table :stall_images do |t|
      t.integer :position, default: 0
      t.references :imageable, polymorphic: true, index: true
      t.attachment :file

      t.timestamps null: false
    end
  end
end
