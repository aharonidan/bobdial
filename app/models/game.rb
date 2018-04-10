class Game < ApplicationRecord
  belongs_to :team_a, class_name: 'Team'
  belongs_to :team_b, class_name: 'Team'

  def not_editable?
    Time.now > deadline || self.not_editable
  end

  def editable?
    not not_editable?
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
end
