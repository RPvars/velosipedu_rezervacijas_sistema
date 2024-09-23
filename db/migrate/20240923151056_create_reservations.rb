class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :bicycle, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.string :purpose
      t.string :status

      t.timestamps
    end
  end
end
