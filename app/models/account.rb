class Account < ApplicationRecord
	has_many :users

	def bets(game:)
		Bet.where(user: users, game: game)
	end
end
