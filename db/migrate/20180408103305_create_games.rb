class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.belongs_to :team_a
      t.belongs_to :team_b
      t.integer  :score_a
      t.integer  :score_b
      t.string   :group
      t.boolean  :is_playoff
      t.datetime :match_time

      t.timestamps
    end
  end
end
