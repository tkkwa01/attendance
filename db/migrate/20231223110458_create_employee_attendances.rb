class CreateEmployeeAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :employee_attendances do |t|
      t.references :employee, null: false, foreign_key: true
      t.datetime :check_in_time
      t.datetime :check_out_time
      t.float :check_in_latitude
      t.float :check_in_longitude
      t.float :check_out_latitude
      t.float :check_out_longitude

      t.timestamps
    end
  end
end
