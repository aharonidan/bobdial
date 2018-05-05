class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.date :report_date

      t.timestamps
    end
  end
end
