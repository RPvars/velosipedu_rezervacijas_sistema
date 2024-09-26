require "test_helper"

class EmployeeTest < ActiveSupport::TestCase
  setup do
    @employee = Employee.new(
      name: "Jānis Bērziņš",
      email: "janis#{Time.now.to_i}@example.com",  # Pievienojam unikālu daļu, lai izvairītos no konflikta
      department: "IT",
      employee_id: "JB#{Time.now.to_i}"  # Pievienojam unikālu daļu, lai izvairītos no konflikta
    )
  end

  test "employee should be valid" do
    assert @employee.valid?, "Darbiniekam jābūt derīgam, bet radās kļūdas: #{@employee.errors.full_messages}"
  end

  test "name should be present" do
    @employee.name = ""
    assert_not @employee.valid?
    assert_includes @employee.errors[:name], "nevar būt tukšs"
  end

  test "email should be present and in valid format" do
    @employee.email = ""
    assert_not @employee.valid?
    assert_includes @employee.errors[:email], "nevar būt tukšs"

    @employee.email = "invalid-email"
    assert_not @employee.valid?
    assert_includes @employee.errors[:email], "nav derīgs"
  end

  test "department should be present and included in the list" do
    @employee.department = ""
    assert_not @employee.valid?
    assert_includes @employee.errors[:department], "nevar būt tukšs"

    @employee.department = "Invalid Department"
    assert_not @employee.valid?
    assert_includes @employee.errors[:department], "nav iekļauts sarakstā"
  end

  test "employee_id should be present and unique" do
    @employee.employee_id = ""
    assert_not @employee.valid?
    assert_includes @employee.errors[:employee_id], "nevar būt tukšs"
  
    @employee.employee_id = "JB#{Time.now.to_i}"
    assert @employee.save
  
    duplicate_employee = @employee.dup
    duplicate_employee.email = "cits#{Time.now.to_i}@example.com"
    assert_not duplicate_employee.valid?
    assert_includes duplicate_employee.errors[:employee_id], "jau ir aizņemts"
  end
end