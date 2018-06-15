class BetsController < ApplicationController
  def create
    params[:bets].each do |game_id, bet|

      game = Game.find(game_id)

      next unless game and bet[:score_a].present? and bet[:score_b].present?

      current_bet = Bet.where(game: game, user: current_user).take

      if current_bet
        current_bet.update(score_a: bet[:score_a], score_b: bet[:score_b])
      else
        Bet.create(game: game, user: current_user, score_a: bet[:score_a], score_b: bet[:score_b], group: game.group)
      end
    end
    redirect_back fallback_location: root_path
  end
end
