class Salary < ApplicationRecord
  belongs_to :employee

  validates :amount, numericality: { greater_than: 0 }
  validates :pay_period_start, :pay_period_end, presence: true
  validate :end_after_start

  private

  # pay_period_end が pay_period_start の後であることを確認するカスタムバリデーション
  def end_after_start
    return if pay_period_start.blank? || pay_period_end.blank?
    if pay_period_end < pay_period_start
      errors.add(:pay_period_end, "must be after the start date")
    end
  end
end
