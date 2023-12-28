class Employee < ApplicationRecord
  has_many :employee_attendance
  has_many :salaries

  has_secure_password
  enum role: { employee: 0, admin: 1, super_user: 2 }

  validates :name, presence: true
  validates :hourly_rate, presence: true
  validates :role, presence: true

  def calculate_monthly_salary(year, month)
    start_date = Date.new(year, month, 1)
    end_date = start_date.end_of_month

    total_hours = employee_attendance.where(check_in_time: start_date..end_date).sum(&:work_hours)
    salary_amount = (total_hours * hourly_rate).round(2)

    salaries.create(amount: salary_amount, pay_period_start: start_date, pay_period_end: end_date)
  end

end