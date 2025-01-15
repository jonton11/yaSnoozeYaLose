class CreateStreakEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :streak_events do |t|
      t.boolean :on_streak
      t.references :challenge_action, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
