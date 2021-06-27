class GamesController < ApplicationController

  before_action :redirect_to_login, unless: :logged_in?

  before_action :redirect_to_login, unless: :admin?, only: [:update]

  def group_stage
    @active_nav_tab = :group_stage
    @active_tab  = params[:group]
    @games       = Game.where(group: params[:group]).order(:id)
    @games_by_round = {}
    deadlines = []
    for game in @games
      @games_by_round[game.deadline] ||= []
      @games_by_round[game.deadline] << game
      deadlines << game.deadline
    end

    deadlines.uniq!
    now = Time.now + 3.hours
    deadlines << now
    deadlines.sort!
    @active_deadline = deadlines[deadlines.index(now) + 1]

    @bets = Bet.where(user: current_user, group: params[:group])
  end

  def knockout_stage
    @active_nav_tab = :knockout_stage
    @active_tab  = params[:phase]
    @games = Game.where(group: params[:phase]).order(:match_time)
    @bets  = Bet.where(user: current_user, group: params[:phase])
  end

  def today
    @active_nav_tab = :today
    @active_tab  = params[:phase]
    @games = Game.where(match_time: Date.today.beginning_of_day..Date.today.end_of_day).order(:match_time)
    @bets  = Bet.where(user: current_user, game: @games)
  end

  def show
    @game = Game.find(params[:id])
    @active_nav_tab = @game.is_playoff ? :knockout_stage : :group_stage
    if @game.editable?(account: current_account)
      redirect_to '/unauthorized'
    else
      @active_tab = :bets
      @bets = current_account.bets(game: @game).includes(:user).order('users.points desc')
    end
    @back = params[:back]
  end

  def stats
    @game = Game.find(params[:id])
    @active_nav_tab = @game.is_playoff ? :knockout_stage : :group_stage
    if @game.editable?(account: current_account)
      redirect_to '/unauthorized'
    else
      @active_tab = :stats
      bets = current_account.bets(game: @game)
      @bets_stats = {}

      for bet in bets
        @bets_stats["#{bet.score_a} - #{bet.score_b}"] ||= 0
        @bets_stats["#{bet.score_a} - #{bet.score_b}"] += 1
      end
    end
  end

  def update
    params[:games].each do |game_id, attrs|
      game = Game.find(game_id)
      to_update = { score_a: attrs[:score_a], score_b: attrs[:score_b], not_editable: attrs[:not_editable]}
      to_update[:team_a_id] = attrs[:team_a_id] if attrs[:team_a_id]
      to_update[:team_b_id] = attrs[:team_b_id] if attrs[:team_b_id]

      game.update(to_update)
    end

    flash[:success] = "Submitted Successfully"
    redirect_to '/admin/settings'
  end
end
