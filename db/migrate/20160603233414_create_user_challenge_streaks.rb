class CreateUserChallengeStreaks < ActiveRecord::Migration[7.1]
  def change
    create_table :user_challenge_streaks do |t|
      t.references :challenge, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :streak_count, default: 0
      t.boolean :vote, default: false

      t.timestamps null: false
    end
  end
end
