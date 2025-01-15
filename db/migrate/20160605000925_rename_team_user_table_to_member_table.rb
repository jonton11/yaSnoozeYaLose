class RenameTeamUserTableToMemberTable < ActiveRecord::Migration[7.1]
  def change
    rename_table :team_users, :members
  end
end
