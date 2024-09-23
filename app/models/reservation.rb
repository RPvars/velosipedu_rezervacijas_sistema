class Reservation < ApplicationRecord
  belongs_to :employee
  belongs_to :bicycle
end
