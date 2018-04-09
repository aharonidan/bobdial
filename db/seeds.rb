# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

teams = [ 
  {name: 'Russia',         group: 'a', black_horse: false, grey_horse: false, after_army_trip: 'asia'},
  {name: 'Saudi Arabia',   group: 'a', black_horse: true,  grey_horse: false, after_army_trip: 'asia'},
  {name: 'Egypt',          group: 'a', black_horse: false, grey_horse: true,  after_army_trip: 'africa'},
  {name: 'Uruguay',        group: 'a', black_horse: false, grey_horse: false, after_army_trip: ''},
  {name: 'Morocco',        group: 'b', black_horse: true,  grey_horse: false, after_army_trip: 'africa'},
  {name: 'Iran',           group: 'b', black_horse: true,  grey_horse: false, after_army_trip: 'asia'},
  {name: 'Portugal',       group: 'b', black_horse: false, grey_horse: false, after_army_trip: ''},
  {name: 'Spain',          group: 'b', black_horse: false, grey_horse: false, after_army_trip: ''},
  {name: 'France',         group: 'c', black_horse: false, grey_horse: false, after_army_trip: ''},
  {name: 'Australia',      group: 'c', black_horse: true,  grey_horse: false, after_army_trip: ''},
  {name: 'Argentina',      group: 'd', black_horse: false, grey_horse: false, after_army_trip: ''},
  {name: 'Iceland',        group: 'd', black_horse: false, grey_horse: true,  after_army_trip: ''},
  {name: 'Peru',           group: 'c', black_horse: false, grey_horse: true,  after_army_trip: ''},
  {name: 'Denmark',        group: 'c', black_horse: false, grey_horse: false, after_army_trip: ''},
  {name: 'Croatia',        group: 'd', black_horse: false, grey_horse: false, after_army_trip: ''},
  {name: 'Nigeria',        group: 'd', black_horse: false, grey_horse: true,  after_army_trip: 'africa'},
  {name: 'Costa Rica',     group: 'e', black_horse: true,  grey_horse: false, after_army_trip: 'central_america'},
  {name: 'Serbia',         group: 'e', black_horse: false, grey_horse: true,  after_army_trip: ''},
  {name: 'Germany',        group: 'f', black_horse: false, grey_horse: false, after_army_trip: ''},
  {name: 'Mexico',         group: 'f', black_horse: false, grey_horse: false, after_army_trip: 'central_america'},
  {name: 'Brazil',         group: 'e', black_horse: false, grey_horse: false, after_army_trip: ''},
  {name: 'Switzerland',    group: 'e', black_horse: false, grey_horse: false, after_army_trip: ''},
  {name: 'Sweden',         group: 'f', black_horse: false, grey_horse: false, after_army_trip: ''},
  {name: 'Korea Republic', group: 'f', black_horse: true,  grey_horse: false, after_army_trip: 'asia'},
  {name: 'Belgium',        group: 'g', black_horse: false, grey_horse: false, after_army_trip: ''},
  {name: 'Panama',         group: 'g', black_horse: true,  grey_horse: false, after_army_trip: 'central_america'},
  {name: 'Tunisia',        group: 'g', black_horse: true,  grey_horse: false, after_army_trip: 'africa'},
  {name: 'England',        group: 'g', black_horse: false, grey_horse: false, after_army_trip: ''},
  {name: 'Colombia',       group: 'h', black_horse: false, grey_horse: false, after_army_trip: ''},
  {name: 'Japan',          group: 'h', black_horse: false, grey_horse: true,  after_army_trip: 'asia'},
  {name: 'Poland',         group: 'h', black_horse: false, grey_horse: false, after_army_trip: ''},
  {name: 'Senegal',        group: 'h', black_horse: false, grey_horse: true,  after_army_trip: 'africa'},
 ]


for team in teams
  Team.create(
    name:            team[:name], 
    group:           team[:group], 
    black_horse:     team[:black_horse], 
    grey_horse:      team[:grey_horse], 
    after_army_trip: team[:after_army_trip]
  )
end

require 'csv'
require 'time'

CSV.foreach('db/worldcup.csv', headers: true) do |row|
  team_a = Team.where(name: row['Home Team']).take
  team_b = Team.where(name: row['Away Team']).take

  next unless team_a and team_b
  
  Game.create(
    team_a:     team_a,
    team_b:     team_b,
    match_time: Time.parse(row['Date']),
    stadium:    row['Location']
  )
end