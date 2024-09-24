# Delete all existing records
Reservation.destroy_all
Employee.destroy_all
Bicycle.destroy_all

# Create employees
employees = [
  { name: "Jānis Bērziņš", email: "janis.berzins@autentica.lv", department: "IT", employee_id: "AUT001" },
  { name: "Līga Kalniņa", email: "liga.kalnina@autentica.lv", department: "Marketing", employee_id: "AUT002" },
  { name: "Andris Ozoliņš", email: "andris.ozolins@autentica.lv", department: "Sales", employee_id: "AUT003" },
  { name: "Ilze Liepiņa", email: "ilze.liepina@autentica.lv", department: "Accounting", employee_id: "AUT004" },
  { name: "Mārtiņš Krūmiņš", email: "martins.krumins@autentica.lv", department: "IT", employee_id: "AUT005" },
  { name: "Inga Zariņa", email: "inga.zarina@autentica.lv", department: "Human Resources", employee_id: "AUT006" },
  { name: "Kārlis Vītols", email: "karlis.vitols@autentica.lv", department: "Sales", employee_id: "AUT007" },
  { name: "Zane Pētersone", email: "zane.petersone@autentica.lv", department: "Marketing", employee_id: "AUT008" },
  { name: "Raimonds Siliņš", email: "raimonds.silins@autentica.lv", department: "Management", employee_id: "AUT009" },
  { name: "Dace Jansone", email: "dace.jansone@autentica.lv", department: "Accounting", employee_id: "AUT010" }
]

employees.each do |employee_data|
  Employee.create!(employee_data)
end

# Create bicycles
bicycles = [
  { model: "Giant FastRoad", status: "available", battery_level: 100, last_maintenance: Date.today - 30 },
  { model: "Trek Verve+", status: "available", battery_level: 85, last_maintenance: Date.today - 15 },
  { model: "Specialized Turbo Vado", status: "in_repair", battery_level: 0, last_maintenance: Date.today }
]

bicycles.each do |bicycle_data|
  Bicycle.create!(bicycle_data)
end

# Create reservations
Reservation.create!(
  employee: Employee.first,
  bicycle: Bicycle.first,
  start_time: DateTime.now + 1.day,
  end_time: DateTime.now + 1.day + 2.hours,
  purpose: "Client meeting",
  status: "active"
)

puts "Seed data has been added successfully!"