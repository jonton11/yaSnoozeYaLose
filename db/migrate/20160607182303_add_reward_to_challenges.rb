class AddRewardToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :reward, :string
  end
end
