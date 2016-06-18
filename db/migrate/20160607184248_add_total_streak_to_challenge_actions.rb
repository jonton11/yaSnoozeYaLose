class AddTotalStreakToChallengeActions < ActiveRecord::Migration
  def change
    add_column :challenge_actions, :total_streak, :integer
  end
end
