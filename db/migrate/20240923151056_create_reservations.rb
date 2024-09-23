class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :bicycle, null: false, foreign_key: true
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :purpose, null: false
      t.string :status, null: false

      t.timestamps
    end

    add_check_constraint :reservations, "end_time > start_time", name: "check_end_time_after_start_time"
    add_check_constraint :reservations, "status IN ('active', 'completed', 'cancelled')", name: "check_valid_status"
  end
end
