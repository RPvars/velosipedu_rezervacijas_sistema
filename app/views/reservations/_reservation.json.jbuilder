json.extract! reservation, :id, :employee_id, :bicycle_id, :start_time, :end_time, :purpose, :status, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
