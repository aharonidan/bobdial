class GamesController < ApplicationController

  before_action :redirect_to_login, unless: :logged_in?

  before_action :redirect_to_login, unless: :admin?, only: [:update]

  def group_stage
    @active_tab  = params[:group]
    @games       = Game.where(group: params[:group])
    @bets        = Bet.where(user: current_user, group: params[:group])
  end

  def knockout_stage
    @active_tab  = params[:phase]
    @games = Game.where(group: params[:phase])
    @bets  = Bet.where(user: current_user, group: params[:phase])
  end

  def show
    @game = Game.find(params[:id])
    @bets = Bet.where(game: @game)
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
