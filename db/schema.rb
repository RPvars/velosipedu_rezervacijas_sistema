# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_09_25_211102) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bicycles", force: :cascade do |t|
    t.string "model", null: false
    t.string "status", null: false
    t.integer "battery_level", null: false
    t.date "last_maintenance", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.check_constraint "battery_level >= 0 AND battery_level <= 100", name: "check_battery_level_range"
    t.check_constraint "status::text = ANY (ARRAY['available'::character varying, 'reserved'::character varying, 'in_repair'::character varying]::text[])", name: "check_valid_status"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "department", null: false
    t.string "employee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["employee_id"], name: "index_employees_on_employee_id", unique: true
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "bicycle_id", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.string "purpose", null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "notification_sent", default: false
    t.index ["bicycle_id"], name: "index_reservations_on_bicycle_id"
    t.index ["employee_id"], name: "index_reservations_on_employee_id"
    t.check_constraint "end_time > start_time", name: "check_end_time_after_start_time"
    t.check_constraint "status::text = ANY (ARRAY['active'::character varying, 'completed'::character varying, 'cancelled'::character varying]::text[])", name: "check_valid_status"
  end

  add_foreign_key "reservations", "bicycles"
  add_foreign_key "reservations", "employees"
end
