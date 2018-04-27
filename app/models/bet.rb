class Bet < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_one :account, through: :user

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

  def bingo?
    score_a == game.score_a and score_b == game.score_b
  end

  def bingo_level_1?
    bingo_specific?(1,0) or bingo_specific?(1,1)
  end

  def bingo_level_2?
    bingo_specific?(0,0) or bingo_specific?(2,0) or bingo_specific?(2,1) or bingo_specific?(3,0)
  end

  def bingo_4_goals_or_more?
    bingo? and (number_of_goals > 3)
  end

  def number_of_goals
    score_a + score_b
  end

  def bingo_specific?(x, y)
    bingo? and ((score_a == x and score_b == y) or (score_a == y and score_b == x))
  end

  def kivoon?
    not bingo? and ((team_a_wins? and game.team_a_wins?) or (team_b_wins? and game.team_b_wins?) or (draw? and game.draw?))
  end

  def goal_difference?
    kivoon? and (score_a - score_b) == (game.score_a - game.score_b)
  end

  def goal_difference_1?
    goal_difference? and (score_a - score_b).abs == 1
  end

  def goal_difference_2_or_more?
    goal_difference? and (score_a - score_b).abs >= 2
  end

  def donkey?
    not bingo? and not kivoon? and score_a == game.score_b and score_b == game.score_a
  end

  def nadir?
    minimum_bets_count <= 3 and minimum_bets_count == my_bet_count
  end

  def bets_and_count
    return @bets_and_count if @bets_and_count

    result = {}
    bets = user.account.bets(game: game)
    for bet in bets
      result["#{bet.score_a}-#{bet.score_b}"] ||= 0
      result["#{bet.score_a}-#{bet.score_b}"] += 1
    end

    @bets_and_count = result
  end

  def minimum_bets_count
    bets_and_count.values.min
  end

  def my_bet_count
    bets_and_count["#{score_a}-#{score_b}"]
  end

  def playoff?
    game.playoff?
  end

  def points

    return unless game.played?

    result = if bingo_level_1?
      5
    elsif bingo_level_2?
      6
    elsif bingo_4_goals_or_more?
      number_of_goals + 3
    elsif goal_difference_2_or_more?
      4
    elsif goal_difference_1?
      3
    elsif kivoon?
      2
    elsif donkey?
      -2
    else
      0
    end

    result += 2 if bingo? and nadir?

    result += 1 if result > 0 and playoff?

    result -= 1 if result < 0 and playoff?

    result

  end
end
