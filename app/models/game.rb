class Game < ApplicationRecord
  belongs_to :team_a, class_name: 'Team'
  belongs_to :team_b, class_name: 'Team'

  def not_editable?
    Time.now > deadline || self.not_editable
  end

  def editable?
    not not_editable?
  end

  def place_holder?
    team_a.group == 'place_holder'
  end

  def self.horses_editable?
    first.editable?
  end

  def self.horses_not_editable?
    first.not_editable?
  end

  def self.phases
    ['round_of_16', 'quarter_finals', 'semi_finals', 'finals']
  end

  def played?
    score_a.present? and score_b.present?
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
end
