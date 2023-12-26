class EmployeeAttendancesController < ApplicationController
  before_action :authenticate_request
  before_action :set_employee_attendance, only: [:update, :destroy]

  def index
    @employee_attendances = @current_employee.employee_attendance
    render json: @employee_attendances
  end

  def create
    @employee_attendance = @current_employee.employee_attendance.build(employee_attendance_params)
    if @employee_attendance.save
      render json: @employee_attendance, status: :created
    else
      render json: @employee_attendance.errors, status: :unprocessable_entity
    end
  end

  def update
    if @employee_attendance.update(employee_attendance_params)
      render json: @employee_attendance
    else
      render json: @employee_attendance.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @employee_attendance.destroy
  end

  private

  def set_employee_attendance
    @employee_attendance = @current_employee.employee_attendance.find(params[:id])
  end

  def employee_attendance_params
    params.require(:employee_attendance).permit(:check_in_time, :check_out_time, :employee_id, :latitude, :longitude)
  end

end
