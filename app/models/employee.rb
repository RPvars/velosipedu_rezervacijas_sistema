class Employee < ApplicationRecord
  has_many :reservations
  has_many :bicycles, through: :reservations

  DEPARTMENTS = ['IT', 'Accounting', 'Sales', 'Marketing', 'Human Resources', 'Management'].freeze

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :department, presence: true, inclusion: { in: DEPARTMENTS }
  validates :employee_id, presence: true, uniqueness: true
end