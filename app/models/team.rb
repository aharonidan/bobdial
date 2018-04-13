class Team < ApplicationRecord

  def self.all_teams
    Team.where.not(group: 'place_holder')
  end

  def self.black_horses
    Team.where(black_horse: true)
  end

  def self.grey_horses
    Team.where(grey_horse: true)
  end

  def self.after_army_trips
    Team.where.not(after_army_trip: '').map(&:after_army_trip).uniq
  end

  def self.after_army_teams(continent)
    Team.where(after_army_trip: continent).map {|team| team.name.titleize }.join(', ')
  end
end
