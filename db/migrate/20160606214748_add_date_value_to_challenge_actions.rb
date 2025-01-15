class AddDateValueToChallengeActions < ActiveRecord::Migration[7.1]
  def change
    add_column :challenge_actions, :track_date, :date
  end
end
