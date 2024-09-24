require "test_helper"

class ReservationTest < ActiveSupport::TestCase
  def setup
    @employee = Employee.create(name: "Jānis Bērziņš", email: "janis@example.com", department: "IT", employee_id: "JB001")
    @bicycle = Bicycle.create(model: "Elektro X1", status: "available", battery_level: 100, last_maintenance: Date.today)
    @reservation = Reservation.new(
      employee: @employee,
      bicycle: @bicycle,
      start_time: DateTime.now + 1.hour,
      end_time: DateTime.now + 2.hours,
      purpose: "Brauciens uz sanāksmi",
      status: "active"
    )
  end

  test "reservation should be valid" do
    assert @reservation.valid?
  end

  test "end time should be after start time" do
    @reservation.end_time = @reservation.start_time - 1.hour
    assert_not @reservation.valid?
    assert_includes @reservation.errors[:end_time], "must be after the start time"
  end

  test "cannot reserve unavailable bicycle" do
    @bicycle.update(status: "in_repair")
    new_reservation = Reservation.new(
      employee: @employee,
      bicycle: @bicycle,
      start_time: DateTime.now + 3.hours,
      end_time: DateTime.now + 4.hours,
      purpose: "Pusdienu brauciens",
      status: "active"
    )
    assert_not new_reservation.valid?
    assert_includes new_reservation.errors[:bicycle], "is not available for reservation"
  end
end