json.extract! employee, :id, :name, :email, :department, :employee_id, :created_at, :updated_at
json.url employee_url(employee, format: :json)
