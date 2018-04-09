class BetsController < ApplicationController
  def create
    params[:bets].each do |game_id, bet|
      
      game = Game.find(game_id)
      
      next unless game and bet[:team_a_score].present? and bet[:team_b_score].present?

      current_bet = Bet.where(game: game, user: current_user).take

      if current_bet
        current_bet.update(team_a_score: bet[:team_a_score], team_b_score: bet[:team_b_score])
      else
        Bet.create(game: game, user: current_user, team_a_score: bet[:team_a_score], team_b_score: bet[:team_b_score], group_or_phase: game.group)
      end
    end
    flash[:success] = "Submitted Successfully"
    redirect_back fallback_location: root_path

  end
end
