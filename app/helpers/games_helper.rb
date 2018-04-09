module GamesHelper

  def user_already_submitted_a_bet? game
    Bet.where(game: game, user: current_user).take
  end
end
