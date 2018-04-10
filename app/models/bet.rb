class Bet < ApplicationRecord
  belongs_to :game
  belongs_to :user

  validate do |bet|
    if bet.game.not_editable?
      bet.errors[:base] << "Bet not editable"
    end
  end

  def score
    1
  end
end
