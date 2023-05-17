class DepartmentsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin, only: [:new, :create, :edit, :update, :destroy]
    before_action :set_department, only: [:show, :edit, :update, :destroy]
  
    def index
      @departments = Department.all
    end
  
    def show
      @users = @department.users
    end
  
    def new
      @department = Department.new
    end
  
    def create
      @department = Department.new(department_params)
      if @department.save
        redirect_to departments_path, notice: 'Department was successfully created.'
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @department.update(department_params)
        redirect_to departments_path, notice: 'Department was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @department.destroy
      redirect_to departments_path, notice: 'Department was successfully deleted.'
    end
  
    private
  
    def set_department
      @department = Department.find(params[:id])
    end
  
    def department_params
      params.require(:department).permit(:name)
    end
  
    def ensure_admin
      unless current_user.admin?
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to root_path
      end
    end
  end
  