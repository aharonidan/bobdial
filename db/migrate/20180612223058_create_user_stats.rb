class CreateUserStats < ActiveRecord::Migration[5.1]
  def change
    create_table :user_stats do |t|
    	t.references :user, foreign_key: true
    	t.references :stat, foreign_key: true
    	t.string :value
      t.timestamps
    end
  end
end
