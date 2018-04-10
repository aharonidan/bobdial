class Team < ApplicationRecord
  def self.team_names
    Team.all.select(:name).map(&:name)
  end

  def self.black_horses
    Team.where(black_horse: true).map(&:name)
  end

  def self.grey_horses
    Team.where(grey_horse: true).map(&:name)
  end

  def self.after_army_trips
    Team.where.not(after_army_trip: '').map(&:after_army_trip).uniq
  end
end
