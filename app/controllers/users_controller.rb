class UsersController < ApplicationController

  before_action :redirect_to_login, unless: :logged_in?, only: [:standings, :horses]

  def new
    @active_nav_tab = :signup

    account = Account.where(name: params[:account_name].downcase).take
    if account
      @user = User.new(account: account)
    else
      flash[:error] = "Account does not exist"
      flash.discard
      render 'set_account'
    end
  end

  def set_account
    @active_nav_tab = :signup
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      flash[:error] = @user.errors.full_messages
      redirect_to "/users/new?account_name=#{@user.account.name}"
    end
  end

  def standings
    @active_nav_tab = :standings
    @active_tab = params[:tab]
    @users = current_account.users.all
    @ranking = Ranker.rank(@users, by: :points)
    render "standings_#{@active_tab}"
  end

  def horses
    @active_nav_tab = :horses
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
    else
      flash[:error] = "Deadline has passed, sorry :("
    end
    redirect_to '/standings/horses'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :account_name)
    end
end
