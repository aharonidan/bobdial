class GamesController < ApplicationController
  
  before_action :redirect_to_root, unless: :logged_in?

  def group_stage
    @active_menu = :group_stage 
    @active_tab  = params[:group]
    @games       = Game.where(group: params[:group])
    @bets        = Bet.where(user: current_user, group_or_phase: params[:group])
  end

  def round_of_16
  end

  def quarter_finals
  end

  def semi_finals
  end

  def final
  end
end
