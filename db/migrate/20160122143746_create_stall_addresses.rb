class CreateStallAddresses < ActiveRecord::Migration[4.2]
  def change
    create_table :stall_addresses do |t|
      t.integer    :civility
      t.string     :first_name
      t.string     :last_name
      t.text       :address
      t.text       :address_details
      t.string     :zip
      t.string     :city
      t.string     :country
      t.string     :phone

      t.timestamps null: false
    end
  end
end
