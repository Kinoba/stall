# This migration comes from stall_engine (originally 20160705110151)
class DummyAddLocaleToStallCustomers < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :stall_customers, :locale, :string, default: I18n.default_locale
  end
end
