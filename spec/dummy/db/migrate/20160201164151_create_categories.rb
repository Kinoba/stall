class DummyCreateCategories < ActiveRecord::Migration[4.2][4.2]
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
