class GamesController < ApplicationController
  def group_stage
    @active_tab = params[:group]
    @games = Game.all.select{ |game| game.team_a.group == params[:group] }
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
