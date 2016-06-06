class AddDateValueToChallengeActions < ActiveRecord::Migration
  def change
    add_column :challenge_actions, :track_date, :date
  end
end
