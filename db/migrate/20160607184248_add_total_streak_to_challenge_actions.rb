class AddTotalStreakToChallengeActions < ActiveRecord::Migration[7.1]
  def change
    add_column :challenge_actions, :total_streak, :integer
  end
end
