class DummyAddCategoryToBooks < ActiveRecord::Migration[4.2][4.2]
  def change
    add_reference :books, :category, index: true, foreign_key: true
  end
end
