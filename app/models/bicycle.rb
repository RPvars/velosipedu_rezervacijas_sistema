class Bicycle < ApplicationRecord
  enum status: { available: 'available', reserved: 'reserved', in_repair: 'in_repair' }

  has_many :reservations
  has_many :employees, through: :reservations

  validates :model, presence: true
  validates :status, presence: true
  validates :battery_level, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :last_maintenance, presence: true
  validate :last_maintenance_cannot_be_in_the_future

  private

  def last_maintenance_cannot_be_in_the_future
    if last_maintenance.present? && last_maintenance > Date.current
      errors.add(:last_maintenance, "nevar būt nākotnē")
    end
  end
end