require "test_helper"

class ReservationTest < ActiveSupport::TestCase
  def setup
    @employee = Employee.create!(
      name: "Jānis Bērziņš",
      email: "janis_#{Time.now.to_i}@example.com",
      department: "IT",
      employee_id: "JB#{Time.now.to_i}"
    )
    @bicycle = Bicycle.create!(model: "Elektro X1", status: "available", battery_level: 100, last_maintenance: Date.today)
    @reservation = Reservation.new(
      employee: @employee,
      bicycle: @bicycle,
      start_time: Time.current + 1.hour,
      end_time: Time.current + 2.hours,
      purpose: "Brauciens uz sanāksmi",
      status: "active"
    )
  end

  test "reservation should be valid" do
    assert @reservation.valid?, "Rezervācijai jābūt derīgai, bet tā nav: #{@reservation.errors.full_messages}"
  end

  test "end time should be after start time" do
    @reservation.end_time = @reservation.start_time - 1.hour
    assert_not @reservation.valid?
    assert_includes @reservation.errors[:end_time], "jābūt pēc sākuma laika"
  end

  test "cannot reserve unavailable bicycle" do
    Reservation.create!(
      employee: Employee.create!(
        name: "Anna Kalna",
        email: "anna_#{Time.now.to_i}@example.com",
        department: "Human Resources",  # Izmantojam atļautu nodaļu no DEPARTMENTS saraksta
        employee_id: "AK#{Time.now.to_i}"
      ),
      bicycle: @bicycle,
      start_time: Time.current + 3.hours,
      end_time: Time.current + 4.hours,
      purpose: "Esošs brauciens",
      status: "active"
    )

    new_reservation = Reservation.new(
      employee: @employee,
      bicycle: @bicycle,
      start_time: Time.current + 3.5.hours,
      end_time: Time.current + 4.5.hours,
      purpose: "Pusdienu brauciens",
      status: "active"
    )

    assert_not new_reservation.valid?
    assert_includes new_reservation.errors[:base], "Velosipēds nav pieejams izvēlētajā laika periodā"
  end
end