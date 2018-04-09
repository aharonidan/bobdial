class AddStadiumToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :stadium, :string
  end
end
