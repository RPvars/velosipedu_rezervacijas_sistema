class CreateBicycles < ActiveRecord::Migration[7.1]
  def change
    create_table :bicycles do |t|
      t.string :model, null: false
      t.string :status, null: false
      t.integer :battery_level, null: false
      t.date :last_maintenance, null: false

      t.timestamps
    end

    add_check_constraint :bicycles, "battery_level >= 0 AND battery_level <= 100", name: "check_battery_level_range"
    add_check_constraint :bicycles, "status IN ('available', 'reserved', 'in_repair')", name: "check_valid_status"
  end
end
