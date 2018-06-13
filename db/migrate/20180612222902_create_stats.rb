class CreateStats < ActiveRecord::Migration[5.1]
  def change
    create_table :stats do |t|
      t.string :name
      t.integer :num_of_groups
      t.string :group_a
      t.string :group_b
      t.string :group_c
      t.string :group_d
      t.string :group_e
      t.string :group_f

      t.timestamps
    end
  end
end
