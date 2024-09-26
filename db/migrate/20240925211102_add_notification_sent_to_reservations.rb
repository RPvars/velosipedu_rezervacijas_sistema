class AddNotificationSentToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :notification_sent, :boolean, default: false
  end
end
