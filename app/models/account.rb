class Account < ApplicationRecord
	has_many :users
	has_many :stats

	def bets(game:)
		Bet.where(user: users, game: game)
	end
end
