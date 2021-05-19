class AddLocaleToStallCustomers < ActiveRecord::Migration[4.2]
  def change
    add_column :stall_customers, :locale, :string, default: I18n.default_locale
  end
end
