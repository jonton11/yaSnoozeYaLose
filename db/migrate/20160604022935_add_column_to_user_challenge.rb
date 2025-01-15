class AddColumnToUserChallenge < ActiveRecord::Migration[7.1]
  def change
    add_column :user_challenge, :vote, :boolean
  end
end
