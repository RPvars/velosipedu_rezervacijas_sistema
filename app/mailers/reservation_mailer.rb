class ReservationMailer < ApplicationMailer
  def reminder_email(reservation)
    @reservation = reservation
    @employee = reservation.employee
    @bicycle = reservation.bicycle
    @cancellation_url = reservation_cancellation_url(@reservation.id)

    mail(to: @employee.email, subject: 'Atgādinājums par velosipēda rezervāciju')
  end
end
