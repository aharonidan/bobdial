class AddDeadlineToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :deadline, :datetime
  end
end
