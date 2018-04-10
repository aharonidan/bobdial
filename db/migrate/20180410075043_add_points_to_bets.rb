class AddPointsToBets < ActiveRecord::Migration[5.1]
  def change
    add_column :bets, :points, :integer
  end
end
