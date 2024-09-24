require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  def setup
    @employee = Employee.new(
      name: "Jānis Bērziņš",
      email: "janis@example.com",
      department: "IT",
      employee_id: "JB001"
    )
  end

  test "employee should be valid" do
    assert @employee.valid?
  end

  test "name should be present" do
    @employee.name = "   "
    assert_not @employee.valid?
    assert_includes @employee.errors[:name], "can't be blank"
  end

  test "email should be unique" do
    duplicate_employee = @employee.dup
    @employee.save
    assert_not duplicate_employee.valid?
    assert_includes duplicate_employee.errors[:email], "has already been taken"
  end

  test "employee_id should be present and unique" do
    @employee.employee_id = "   "
    assert_not @employee.valid?
    assert_includes @employee.errors[:employee_id], "can't be blank"

    @employee.employee_id = "JB001"
    @employee.save
    duplicate_employee = Employee.new(
      name: "Anna Kalniņa",
      email: "anna@example.com",
      department: "HR",
      employee_id: "JB001"
    )
    assert_not duplicate_employee.valid?
    assert_includes duplicate_employee.errors[:employee_id], "has already been taken"
  end
end