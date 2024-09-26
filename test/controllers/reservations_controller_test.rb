require "test_helper"

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reservation = reservations(:one)
    @new_reservation_attributes = {
      bicycle_id: bicycles(:available_bicycle).id,
      employee_id: employees(:available_employee).id,
      start_time: Time.current + 1.hour,
      end_time: Time.current + 2.hours,
      purpose: "Testa rezervācija",
      status: "active"
    }
  end

  test "should get index" do
    get reservations_url
    assert_response :success
  end

  test "should get new" do
    get new_reservation_url
    assert_response :success
  end

  test "should create reservation" do
    assert_difference("Reservation.count") do
      post reservations_url, params: { reservation: @new_reservation_attributes }
    end

    assert_redirected_to reservation_url(Reservation.last)
    assert_equal "Rezervācija veiksmīgi izveidota.", flash[:notice]
  end

  test "should not create invalid reservation" do
    assert_no_difference("Reservation.count") do
      post reservations_url, params: { reservation: @new_reservation_attributes.merge(start_time: nil) }
    end
    assert_response :unprocessable_entity
  end

  test "should show reservation" do
    get reservation_url(@reservation)
    assert_response :success
  end

  test "should get edit" do
    get edit_reservation_url(@reservation)
    assert_response :success
  end

  test "should update reservation" do
    patch reservation_url(@reservation), params: { reservation: { purpose: "Atjaunināts mērķis" } }
    assert_redirected_to reservation_url(@reservation)
    assert_equal "Rezervācija veiksmīgi atjaunināta.", flash[:notice]
  end

  test "should not update reservation with invalid data" do
    patch reservation_url(@reservation), params: { reservation: { start_time: nil } }
    assert_response :unprocessable_entity
  end

  test "should destroy reservation" do
    assert_difference("Reservation.count", -1) do
      delete reservation_url(@reservation)
    end

    assert_redirected_to reservations_url
    assert_equal "Rezervācija veiksmīgi dzēsta.", flash[:notice]
  end
end