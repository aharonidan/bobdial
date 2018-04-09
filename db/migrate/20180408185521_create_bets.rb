class CreateBets < ActiveRecord::Migration[5.1]
  def change
    create_table :bets do |t|
      t.references :game, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :team_a_score
      t.integer :team_b_score
      t.string  :group_or_phase

      t.timestamps
    end
  end
end
