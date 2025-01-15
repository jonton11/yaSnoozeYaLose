class AddTotalStreakToStreakEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :streak_events, :total_streak, :integer, default: 0
  end
end
