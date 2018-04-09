class AddIndexToBets < ActiveRecord::Migration[5.1]
  def change
    add_index :bets, [:user_id, :game_id], unique: true
  end
end
