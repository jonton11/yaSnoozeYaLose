class AddColumnToUserChallenge < ActiveRecord::Migration
  def change
    add_column :user_challenge, :vote, :boolean
  end
end
