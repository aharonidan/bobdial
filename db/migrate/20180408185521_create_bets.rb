class CreateBets < ActiveRecord::Migration[5.1]
  def change
    create_table :bets do |t|
      t.references :game, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :score_a
      t.integer :score_b
      t.string  :group

      t.timestamps
    end
  end
end
