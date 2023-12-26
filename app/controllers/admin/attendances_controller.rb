module Admin
  class AttendancesController < ApplicationController
    before_action :authenticate_request
    before_action :check_admin_role
    before_action :set_attendance, only: [:show, :update, :destroy]

    def index
      @attendances = Attendance.all
      render json: @attendances
    end

    def show
      render json: @attendance
    end

    def update
      if @attendance.update(attendance_params)
        render json: @attendance
      else
        render json: @attendance.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @attendance.destroy
      head :no_content
    end

    private

    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    def check_admin_role
      render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_employee.admin?
    end

    def attendance_params
      params.require(:attendance).permit(:check_in_time, :check_out_time, :latitude, :longitude)
    end

  end
end
