class Team < ApplicationRecord

  def self.all_teams
    Team.where.not(group: 'place_holder')
  end

  def self.winner_options
    Team.where(name: ['france', 'england', 'belgium', 'spain', 'portugal', 'italy'])
  end

  def self.black_horses
    Team.where(name: ['north_macedonia', 'finland', 'hungary'])
  end

  def self.grey_horses
    Team.where(name: ['slovakia', 'scotland', 'czech_republic', 'sweden', 'austria', 'turkey', 'russia', 'switzerland', 'wales'])
  end
end
