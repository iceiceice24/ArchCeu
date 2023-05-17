class Admin::UsersController < ApplicationController
    before_action :authenticate_admin!
  
    def edit
        @user = User.find(params[:id])
    end

    def index
        @users = User.all
        @department = Department.all
    end 

    def update
      @user = User.find(params[:id])
      if current_user.admin?
        params[:user].delete(:password) if params[:user][:password].blank?
        params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
      end

      if @user.update(user_params)
        redirect_to admin_users_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end

    def delete_user
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_path, notice: "User deleted successfully."
    end
    
  
    private
  
    def user_params
      params.require(:user).permit(:email,:full_name, :password, :password_confirmation, :role, :department_id,:fileSizelimit,:maxFileSize)
    end
    private

    def authenticate_admin!
        unless current_user && current_user.admin?
        redirect_to root_path, alert: "You are not authorized to access this page."
        end
    end

  end
  