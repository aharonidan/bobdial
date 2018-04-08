class Game < ApplicationRecord
  belongs_to :team_a, class_name: 'Team'
  belongs_to :team_b, class_name: 'Team'
end
