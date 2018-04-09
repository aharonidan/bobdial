class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :group
      t.boolean :black_horse
      t.boolean :grey_horse
      t.string :after_army_trip

      t.timestamps
    end
  end
end
