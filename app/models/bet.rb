class Bet < ApplicationRecord
  belongs_to :game
  belongs_to :user

  validate do |bet|
    if bet.game.not_editable?
      bet.errors[:base] << "Bet not editable"
    end
  end

  def team_a_wins?
    score_a > score_b
  end

  def team_b_wins?
    score_a < score_b
  end

  def draw?
    score_a == score_b
  end

  def points
    return unless game.played?



  end
end
