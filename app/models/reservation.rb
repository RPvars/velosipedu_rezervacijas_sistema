class Reservation < ApplicationRecord
  belongs_to :employee
  belongs_to :bicycle

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :purpose, presence: true
  validates :status, presence: true, inclusion: { in: ['active', 'completed', 'cancelled'] }

  validate :end_time_after_start_time
  validate :bicycle_available

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time <= start_time
      errors.add(:end_time, "must be after the start time")
    end
  end

  def bicycle_available
    return if bicycle.blank? || start_time.blank?

    if bicycle.status != "available"
      errors.add(:bicycle, "is not available for reservation")
    end
  end

end