class AddNotEditableColumnToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :not_editable, :boolean
  end
end
