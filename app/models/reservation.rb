class Reservation < ApplicationRecord
  belongs_to :employee
  belongs_to :bicycle

  enum status: {
    active: 'active',
    completed: 'completed',
    cancelled: 'cancelled'
  }

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :purpose, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }

  validate :end_time_after_start_time
  validate :bicycle_available

  scope :upcoming, -> { where('start_time > ?', Time.current).where(status: 'active') }
  scope :need_notification, -> { upcoming.where('start_time <= ?', 1.day.from_now).where(notification_sent: false) }

  def send_reminder
    ReservationMailer.reminder_email(self).deliver_now
    update(notification_sent: true)
  end

  def cancel
    update(status: 'cancelled')
  end

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time <= start_time
      errors.add(:end_time, "jābūt pēc sākuma laika")
    end
  end

  def bicycle_available
    return if bicycle.blank? || start_time.blank? || end_time.blank?

    overlapping_reservations = Reservation.where(bicycle: bicycle)
                                          .where('start_time < ? AND end_time > ?', end_time, start_time)
                                          .where.not(id: id)
                                          .where.not(status: 'cancelled')

    if overlapping_reservations.exists?
      errors.add(:base, "Velosipēds nav pieejams izvēlētajā laika periodā")
    end
  end
end