class Game < ApplicationRecord
  belongs_to :team_a, class_name: 'Team'
  belongs_to :team_b, class_name: 'Team'

  def not_editable?
    Time.now > match_time || self.not_editable
  end

  def self.phases
    ['round_of_16', 'quarter_finals', 'semi_finals', 'final']
  end
end
