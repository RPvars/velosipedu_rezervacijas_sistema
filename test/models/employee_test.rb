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
    @employee.name = ""
    assert_not @employee.valid?
    assert_includes @employee.errors[:name], I18n.t('errors.messages.blank')
  end

  test "email should be unique" do
    duplicate_employee = @employee.dup
    @employee.save
    assert_not duplicate_employee.valid?
    assert_includes duplicate_employee.errors[:email], I18n.t('errors.messages.taken')
  end

  test "employee_id should be present and unique" do
    @employee.employee_id = ""
    assert_not @employee.valid?
    assert_includes @employee.errors[:employee_id], I18n.t('errors.messages.blank')

    @employee.employee_id = "EMP123"
    @employee.save
    duplicate_employee = Employee.new(name: "Jane Doe", email: "jane@example.com", department: "HR", employee_id: "EMP123")
    assert_not duplicate_employee.valid?
    assert_includes duplicate_employee.errors[:employee_id], I18n.t('errors.messages.taken')
  end
end