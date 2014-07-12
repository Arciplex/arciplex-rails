class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!

  respond_to :js, :html

  def index
    @users = User.all.paginate(page: params[:page])

    respond_with @users
  end

  def show
    @user = User.find(params[:id])

    respond_with @user
  end

  def new
    @user = User.new
    @companies = Company.all

    respond_with @user
  end

  def create
    @user = User.new(user_params)

    if @user.save!
      @user.notify
      redirect_to admin_user_path(@user), notice: "User created!"
    else
      @companies = Company.all
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    @companies = Company.all

    respond_with @user
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user), notice: "User Updated!"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "User Removed"
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :role, :company_id)
    end
end
