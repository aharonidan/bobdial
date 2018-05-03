class AddNadirSettingToAccounts < ActiveRecord::Migration[5.1]
  def change
  	add_column :accounts, :nadir_enabled, :boolean
  end
end
