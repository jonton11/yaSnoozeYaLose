class RenameUserChallengeToChallengeAction < ActiveRecord::Migration[7.1]
  def change
    rename_table :user_challenge, :challenge_actions
  end
end
