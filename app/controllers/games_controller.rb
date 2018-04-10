class GamesController < ApplicationController
  
  before_action :redirect_to_login, unless: :logged_in?

  before_action :redirect_to_login, unless: :admin?, only: [:update, :create]

  def group_stage
    @active_tab  = params[:group]
    @games       = Game.where(group: params[:group])
    @bets        = Bet.where(user: current_user, group_or_phase: params[:group])
  end

  def knockout_stage
    @active_tab  = params[:phase]
    @games = Game.where(group: params[:phase])
    @bets  = Bet.where(user: current_user, group_or_phase: params[:phase])
  end

  def show
    @game = Game.find(params[:id])
    @bets = Bet.where(game: @game)
  end

  def update
    params[:games].each do |game_id, attrs|  
      game = Game.find(game_id)
      game.update(score_a: attrs[:score_a], score_b: attrs[:score_b], not_editable: attrs[:not_editable])
    end

    flash[:success] = "Submitted Successfully"
    redirect_to '/admin/settings'
  end

  def new
    @game = Game.new
  end

  def create
    team_a = Team.where(name: params[:game][:team_a]).take
    team_b = Team.where(name: params[:game][:team_b]).take

    Game.create(team_a: team_a, team_b: team_b, match_time: params[:game][:match_time], group: params[:game][:group], is_playoff: true)
    flash[:success] = "Submitted Successfully"
    redirect_to '/admin/settings'
  end
end
