class AddDefaultValueToUserChallenge < ActiveRecord::Migration
  def change
    change_column_default(:user_challenge, :vote, false)
    change_column_default(:user_challenge, :streak_count, 0)
  end
end
