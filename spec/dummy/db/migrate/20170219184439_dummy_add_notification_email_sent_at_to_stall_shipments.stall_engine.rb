# This migration comes from stall_engine (originally 20170217153634)
class DummyAddNotificationEmailSentAtToStallShipments < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :stall_shipments, :notification_email_sent_at, :datetime
  end
end
