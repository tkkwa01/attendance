module Admin
  class SalariesController < ApplicationController
    before_action :authenticate_request
    before_action :check_admin_role

    # POST /admin/salaries/calculate
    def calculate
      year = params[:year].to_i
      month = params[:month].to_i

      Employee.find_each do |employee|
        employee.calculate_monthly_salary(year, month)
      end

      render json: { message: "Salaries for #{month}/#{year} calculated successfully" }
    end

    # GET /admin/salaries/employee/:id
    def show_employee_salary
      employee = Employee.find_by(id: params[:id])
      return render json: { error: 'Employee not found' }, status: :not_found unless employee

      year = params[:year].to_i
      month = params[:month].to_i

      salary = employee.salaries.find_by(pay_period_start: Date.new(year, month, 1), pay_period_end: Date.new(year, month, -1))
      if salary
        render json: salary
      else
        render json: { error: 'Salary not calculated for this period' }, status: :not_found
      end
    end



    private

    def check_admin_role
      render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_employee.admin?
    end
  end
end
