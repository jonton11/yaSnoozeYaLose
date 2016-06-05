class RenameTeamUserTableToMemberTable < ActiveRecord::Migration
  def change
    rename_table :team_users, :members
  end
end
