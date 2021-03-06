class Bet < ApplicationRecord
  belongs_to :game
  belongs_to :user
  has_one :account, through: :user

  validate do |bet|
    if bet.game.not_editable?(account: user.account) and (score_a_changed? or score_b_changed?)
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
    return false unless game.played?
    score_a == game.score_a and score_b == game.score_b
  end

  def bingo_type_1?
    bingo_specific?(1,0) or bingo_specific?(1,1)
  end

  def bingo_type_2?
    bingo_specific?(0,0) or bingo_specific?(2,0) or bingo_specific?(2,1) or bingo_specific?(3,0)
  end

  def bingo_type_3?
    bingo_specific?(2,0) or bingo_specific?(1,1) or bingo_specific?(2,1) or bingo_specific?(3,0)
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

  def abs_goal_difference?
    (score_a - score_b).abs == (game.score_a - game.score_b).abs
  end

  def goal_difference_1?
    goal_difference? and (score_a - score_b).abs == 1
  end

  def goal_difference_2_or_more?
    goal_difference? and (score_a - score_b).abs >= 2
  end

  def donkey?
    return false unless game.played?
    not bingo? and not kivoon? and not draw? and abs_goal_difference?
  end

  def nadir?
    return false if nadir_functionality_disabled_for_account
    my_kivoon_count <= 3
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

  def kivoon_and_count
    return @kivoon_and_count if @kivoon_and_count
    
    result = {}

    bets = user.account.bets(game: game)
    for bet in bets
      if bet.team_a_wins?
        result[:team_a] ||= 0
        result[:team_a] += 1
      elsif bet.team_b_wins?
        result[:team_b] ||= 0
        result[:team_b] += 1
      elsif bet.draw?
        result[:draw] ||= 0
        result[:draw] += 1
      end
    end
    @kivoon_and_count = result
  end

  def minimum_bets_count
    kivoon_and_count.values.min
  end

  def my_kivoon
    if team_a_wins?
      :team_a
    elsif team_b_wins?
      :team_b
    elsif draw?
      :draw
    end
  end

  def my_kivoon_count
    kivoon_and_count[my_kivoon]
  end

  def nadir_functionality_disabled_for_account
    not user.account.nadir_enabled
  end

  def playoff?
    game.playoff?
  end

  def points

    return super if super
    return unless game.played?

    if not playoff?
      result = if bingo_type_1?
        5
      elsif bingo_type_2?
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

    elsif playoff?
      result = if bingo_specific?(1, 0)
        7
      elsif bingo_type_3?
        8
      elsif bingo_specific?(0, 0)
        9
      elsif bingo_4_goals_or_more?
        number_of_goals + 5
      elsif goal_difference_2_or_more?
        6
      elsif goal_difference_1?
        5
      elsif draw? and kivoon?
        4
      elsif kivoon?
        3
      elsif donkey?
        -3
      else
        0
      end
    end

    result += 3 if nadir? and (kivoon? or bingo?)

    update(points: result)

    result

  end
end
