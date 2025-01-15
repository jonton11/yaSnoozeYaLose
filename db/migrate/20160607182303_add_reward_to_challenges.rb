class AddRewardToChallenges < ActiveRecord::Migration[7.1]
  def change
    add_column :challenges, :reward, :string
  end
end
