class EmailService
  def self.send_reservation_reminder(reservation)
    ReservationMailer.reminder_email(reservation).deliver_now
    reservation.update(notification_sent: true)
  end
end
