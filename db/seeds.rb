# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'csv'
require 'time'

CSV.foreach('db/teams.csv', headers: true) do |row|
  Team.create(
    name: row['team'].parameterize(separator: '_'),
    group: row['group']
  )
end



deadlines = {
  '1' => Time.parse('11/06/2021 18:00'),
  '2' => Time.parse('16/06/2021 12:00'),
  '3' => Time.parse('16/06/2021 12:00'),
  'Round of 16' => Time.parse('26/06/2021 15:00'),
  'Quarter Finals' => Time.parse('02/07/2021 15:00'),
  'Semi Finals' => Time.parse('06/07/2021 18:00'),
  'Final' => Time.parse('11/07/2021 18:00'),
}

CSV.foreach('db/matches.csv', headers: true) do |row|
  team_a = Team.where(name: row['team_a'].parameterize(separator: '_')).take
  team_b = Team.where(name: row['team_b'].parameterize(separator: '_')).take

  next unless team_a and team_b

  if team_a.group == 'place_holder'
    group = row['round'].parameterize(separator: '_')
    is_playoff = true
  else
    group = team_a.group
    is_playoff = false
  end

  Game.create(
    team_a:     team_a,
    team_b:     team_b,
    group: group,
    match_time: Time.parse(row['date'] + ' ' + row['time']),
    deadline: deadlines[row['round']],
    stadium:    row['location'],
    is_playoff: is_playoff
  )
end

Account.create(name: 'test')
