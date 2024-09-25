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

created_employees = employees.map { |employee_data| Employee.create!(employee_data) }

# Create bicycles
bicycles = [
  { model: "Giant FastRoad", status: "available", battery_level: 100, last_maintenance: Date.today - 30 },
  { model: "Trek Verve+", status: "available", battery_level: 85, last_maintenance: Date.today - 15 },
  { model: "Specialized Turbo Vado", status: "in_repair", battery_level: 0, last_maintenance: Date.today }
]

created_bicycles = bicycles.map { |bicycle_data| Bicycle.create!(bicycle_data) }

# Create reservations
reservations = [
  {
    employee: created_employees.find { |e| e.name == "Līga Kalniņa" },
    bicycle: created_bicycles.find { |b| b.model == "Giant FastRoad" },
    start_time: DateTime.now + 2.days,
    end_time: DateTime.now + 2.days + 3.hours,
    purpose: "Klienta prezentācija",
    status: "active"
  },
  {
    employee: created_employees.find { |e| e.name == "Andris Ozoliņš" },
    bicycle: created_bicycles.find { |b| b.model == "Trek Verve+" },
    start_time: DateTime.now + 3.days,
    end_time: DateTime.now + 3.days + 1.hour,
    purpose: "Piegāde",
    status: "active"
  },
  {
    employee: created_employees.find { |e| e.name == "Mārtiņš Krūmiņš" },
    bicycle: created_bicycles.find { |b| b.model == "Giant FastRoad" },
    start_time: DateTime.now - 1.day,
    end_time: DateTime.now - 1.day + 4.hours,
    purpose: "Komandas saliedēšanas pasākums",
    status: "completed"
  },
  {
    employee: created_employees.find { |e| e.name == "Zane Pētersone" },
    bicycle: created_bicycles.find { |b| b.model == "Trek Verve+" },
    start_time: DateTime.now + 5.days,
    end_time: DateTime.now + 5.days + 2.hours,
    purpose: "Fotogrāfēšana reklāmai",
    status: "active"
  },
  {
    employee: created_employees.find { |e| e.name == "Kārlis Vītols" },
    bicycle: created_bicycles.find { |b| b.model == "Giant FastRoad" },
    start_time: DateTime.now + 1.day,
    end_time: DateTime.now + 1.day + 5.hours,
    purpose: "Tikšanās ar potenciālo klientu",
    status: "active"
  },
  {
    employee: created_employees.find { |e| e.name == "Ilze Liepiņa" },
    bicycle: created_bicycles.find { |b| b.model == "Trek Verve+" },
    start_time: DateTime.now + 4.days,
    end_time: DateTime.now + 4.days + 1.hour,
    purpose: "Dokumentu nogādāšana",
    status: "active"
  },
  {
    employee: created_employees.find { |e| e.name == "Raimonds Siliņš" },
    bicycle: created_bicycles.find { |b| b.model == "Giant FastRoad" },
    start_time: DateTime.now - 2.days,
    end_time: DateTime.now - 2.days + 3.hours,
    purpose: "Biznesa brokastis",
    status: "completed"
  },
  {
    employee: created_employees.find { |e| e.name == "Dace Jansone" },
    bicycle: created_bicycles.find { |b| b.model == "Trek Verve+" },
    start_time: DateTime.now + 6.days,
    end_time: DateTime.now + 6.days + 4.hours,
    purpose: "Konference",
    status: "active"
  },
  {
    employee: created_employees.find { |e| e.name == "Jānis Bērziņš" },
    bicycle: created_bicycles.find { |b| b.model == "Giant FastRoad" },
    start_time: DateTime.now + 7.days,
    end_time: DateTime.now + 7.days + 2.hours,
    purpose: "Tehniskā apskate",
    status: "active"
  },
  {
    employee: created_employees.find { |e| e.name == "Inga Zariņa" },
    bicycle: created_bicycles.find { |b| b.model == "Trek Verve+" },
    start_time: DateTime.now - 3.days,
    end_time: DateTime.now - 3.days + 1.hour,
    purpose: "Intervija ar kandidātu",
    status: "cancelled"
  }
]

# Create the reservations
reservations.each do |reservation_data|
  Reservation.create!(reservation_data)
end

puts "Seed data has been added successfully!"