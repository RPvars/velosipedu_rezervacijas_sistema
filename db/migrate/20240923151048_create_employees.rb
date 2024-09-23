class CreateEmployees < ActiveRecord::Migration[7.1]
  def change
    create_table :employees do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :department, null: false
      t.string :employee_id, null: false

      t.timestamps
    end

    add_index :employees, :email, unique: true
    add_index :employees, :employee_id, unique: true
  end
end
