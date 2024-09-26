namespace :reservation_reminders do
  desc "Nosūta atgādinājumus par gaidāmajām rezervācijām"
  task send: :environment do
    Reservation.need_notification.find_each do |reservation|
      EmailService.send_reservation_reminder(reservation)
    end
  end
end
