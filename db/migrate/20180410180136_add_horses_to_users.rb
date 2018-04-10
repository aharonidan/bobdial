class AddHorsesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :black_horse_id, :integer
    add_column :users, :grey_horse_id, :integer
    add_column :users, :champion_id, :integer
  end
end
