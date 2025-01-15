class CreateChallenges < ActiveRecord::Migration[7.1]
  def change
    create_table :challenges do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.references :team, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
