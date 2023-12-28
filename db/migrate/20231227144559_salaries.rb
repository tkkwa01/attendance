class Salaries < ActiveRecord::Migration[7.0]
  def change
    create_table :salaries do |t|
      t.references :employee, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2
      t.date :pay_period_start
      t.date :pay_period_end

      t.timestamps
    end
  end
end
