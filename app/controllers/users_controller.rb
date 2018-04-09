class UsersController < ApplicationController
  
  before_action :redirect_to_login, unless: :logged_in?, only: [:show, :table]

  def new
  	@user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def table
    @users = User.all
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
