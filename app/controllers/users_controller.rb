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
      redirect_to '/table'
    else
      render 'new'
    end
  end

  def table
    @users = User.all
  end

  def horses
  end

  def update_horses

    if Game.horses_editable?
      current_user.update(
        black_horse_id: params[:black_horse_id],
        grey_horse_id: params[:grey_horse_id],
        champion_id: params[:champion_id],
        top_scorer: params[:top_scorer],
        after_army_trip: params[:after_army_trip]
      )
      flash[:success] = "Submitted Successfully"
    else
      flash[:error] = "Deadline has passed, sorry :("
    end
    redirect_to '/horses'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end