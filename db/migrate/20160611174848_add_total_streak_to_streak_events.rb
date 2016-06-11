class AddTotalStreakToStreakEvents < ActiveRecord::Migration
  def change
    add_column :streak_events, :total_streak, :integer, default: 0
  end
end
