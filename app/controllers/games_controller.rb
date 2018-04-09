class GamesController < ApplicationController
  
  before_action :redirect_to_root, unless: :logged_in?

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
end
