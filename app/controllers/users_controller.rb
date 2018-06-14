class UsersController < ApplicationController

  before_action :redirect_to_login, unless: :logged_in?, only: [:standings, :my_bets, :all_bets]

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
      log_in @user
      remember @user
      redirect_to '/standings/points'
      flash.discard
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

    calculate_statistics if @active_tab == 'statistics'
    render "standings_#{@active_tab}"
  end

  def my_bets
    @active_nav_tab = :special_bets
    @active_tab = :my_bets
  end

  def all_bets
    @active_nav_tab = :special_bets
    @active_tab = :all_bets
    @users = current_account.users.all
    @ranking = Ranker.rank(@users, by: :points)
  end

  def statistics
    @active_nav_tab = :standings
    @active_tab = 'statistics'
    @active_subtab = params[:tab]

    calculate_statistics

    render "standings_statistics"

  end

  def calculate_statistics
    case params[:tab]

    when 'leaders'
      calculate_statistics_leaders
    when 'segments'
      calculate_statistics_segments
    end
  end

  def calculate_statistics_leaders
    @nadir_chart = {}
    for user in current_account.users
      @nadir_chart[user.name] = 0
      for bet in user.bets
        next if bet.game.editable?
        @nadir_chart[user.name] += 1 if bet.nadir?
      end
    end
    @nadir_chart = @nadir_chart.sort_by { |_, v| -v }.first(5)
  end


  def calculate_statistics_segments
    @charts_data = []
    @groups_data = []
    for stat in current_account.stats
      chart = {}
      groups = {}

      for user in current_account.users
        if user_stat = user.user_stats.where(stat: stat).take
          category = stat.send(user_stat.value)

          chart[category] ||= [0, 0]

          chart[category][0] += 1
          chart[category][1] += user.points
          groups[category] ||= []
          groups[category] << user.name
        end
      end
      chart.each {|k,v| chart[k] = chart[k][1] / Float(chart[k][0])}
      @charts_data << chart
      @groups_data << groups
    end
  end

  def update_horses

    if Game.horses_editable?(account: current_account)
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
