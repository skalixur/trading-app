module Admin
  class UsersController < ApplicationController
    before_action :set_user, only: [ :edit, :update, :destroy ]

    def index
      @users = User.where(is_admin: false).order(name: :asc)
      if params[:filter] == "Pending"
        @users = User.where(is_admin: false, is_approved: false).order(name: :asc)
      elsif params[:filter] == "Approved"
         @users = User.where(is_admin: false, is_approved: true).order(name: :asc)
      end
    end

    def new
      @user = User.new
    end

    def transactions
      @trans = Transaction.all
      @users = User.all
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path, notice: "User created successfully"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @user.update(user_params)
        redirect_to admin_users_path, notice: "User updated successfully"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def approve
      @user = User.find(params[:id])
      @user.update(is_approved: true)
      ApprovalMailer.approval_email(@user).deliver_now
      redirect_to admin_users_path, notice: "User approved"
    end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice: "User deleted successfully"
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :balance)
    end
  end
end
