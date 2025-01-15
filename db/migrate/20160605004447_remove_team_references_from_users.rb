class RemoveTeamReferencesFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :team_id
  end
end
