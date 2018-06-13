class AddAccountToStats < ActiveRecord::Migration[5.1]
  def change
  	add_column :stats, :account_id, :integer
  end
end
