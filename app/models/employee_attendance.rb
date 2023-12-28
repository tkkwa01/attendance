class EmployeeAttendance < ApplicationRecord
  belongs_to :employee

  validates :check_in_time, presence: true
  validate :check_out_after_check_in

  def work_hours
    return 0 unless check_in_time && check_out_time
    ((check_out_time - check_in_time) / 1.hour).round(2)
  end

  private
  def check_out_after_check_in
    return if check_out_time.blank? || check_in_time.blank?
    if check_out_time < check_in_time
      errors.add(:check_out_time, "must be after the check in time")
    end
  end
end
