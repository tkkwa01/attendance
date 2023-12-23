class Employee < ApplicationRecord
  has_many :employee_attendance
  has_secure_password
  enum role: { employee: 0, admin: 1, super_user: 2 }

  validates :name, presence: true
  validates :hourly_rate, presence: true
  validates :role, presence: true
end
