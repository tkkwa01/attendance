class EmployeesController < ApplicationController
  before_action :authenticate_request, only: [:create, :update, :destroy]
  before_action :set_employee, only: [:show, :update, :destroy]
  before_action :check_admin_role, only: [:create, :update, :destroy]

  # GET /employees
  def index
    @employees = Employee.all
    render json: @employees
  end

  # GET /employees/:id
  def show
    render json: @employee
  end

  # POST /employees
  def create
    Rails.logger.info "Received parameters: #{employee_params.inspect}"

    @employee = Employee.new(employee_params)
    if @employee.save
      render json: @employee, status: :created, location: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /employees/:id
  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # DELETE /employees/:id
  def destroy
    @employee.destroy
    head :no_content
  end

  private


  private

  def set_employee
    @employee = Employee.find_by(id: params[:id])
    render json: { error: 'Not Found' }, status: :not_found unless @employee
  end

  def employee_params
    params.require(:employee).permit(:name, :hourly_rate, :role, :password, :password_confirmation)
  end

  def check_admin_role
    unless @current_employee&.admin?
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
  end
  end
