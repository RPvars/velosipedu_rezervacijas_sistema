require 'test_helper'

class BicycleTest < ActiveSupport::TestCase
  def setup
    @bicycle = Bicycle.new(
      model: "Elektro X1",
      status: "available",
      battery_level: 100,
      last_maintenance: Date.today
    )
  end

  test "bicycle should be valid" do
    assert @bicycle.valid?
  end

  test "model should be present" do
    @bicycle.model = ""
    assert_not @bicycle.valid?
  end

  test "status should be present" do
    @bicycle.status = ""
    assert_not @bicycle.valid?
  end

  test "status should be valid" do
    valid_statuses = ['available', 'reserved', 'in_repair']
    valid_statuses.each do |status|
      @bicycle.status = status
      assert @bicycle.valid?, "#{status} should be a valid status"
    end
  end
  
  test "status should not be invalid" do
    assert_raises(ArgumentError) do
      @bicycle.status = "invalid_status"
    end
  end
  
  test "status should not be nil" do
    @bicycle.status = nil
    assert_not @bicycle.valid?
    assert_includes @bicycle.errors[:status], I18n.t('errors.messages.blank')
  end


  test "battery_level should be present" do
    @bicycle.battery_level = nil
    assert_not @bicycle.valid?
  end

  test "battery_level should be between 0 and 100" do
    @bicycle.battery_level = -1
    assert_not @bicycle.valid?

    @bicycle.battery_level = 101
    assert_not @bicycle.valid?

    @bicycle.battery_level = 0
    assert @bicycle.valid?

    @bicycle.battery_level = 100
    assert @bicycle.valid?
  end

  test "last_maintenance should be present" do
    @bicycle.last_maintenance = nil
    assert_not @bicycle.valid?
  end

  test "last_maintenance_should_not_be_in_the_future" do
    bicycle = Bicycle.new(
      model: "Test Model",
      status: :available,
      battery_level: 100,
      last_maintenance: Date.tomorrow
    )
    assert_not bicycle.valid?
    assert_includes bicycle.errors[:last_maintenance], "nevar būt nākotnē"
  end
end