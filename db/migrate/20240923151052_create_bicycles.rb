class CreateBicycles < ActiveRecord::Migration[7.1]
  def change
    create_table :bicycles do |t|
      t.string :model
      t.string :status
      t.integer :battery_level
      t.date :last_maintenance

      t.timestamps
    end
  end
end
