class AddTeamReferencesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :team, index: true, foreign_key: true
  end
end
