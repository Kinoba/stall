class ChangeVariantsWeightDefaultToNil < ActiveRecord::Migration[4.2]
  def up
    change_column_default :stall_variants, :weight, nil

    Variant.where(weight: 0).find_each { |v| v.update(weight: nil) }
  end

  def down
    change_column_default :stall_variants, :weight, 0
  end
end
