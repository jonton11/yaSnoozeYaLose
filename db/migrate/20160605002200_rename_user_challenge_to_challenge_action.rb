class RenameUserChallengeToChallengeAction < ActiveRecord::Migration
  def change
    rename_table :user_challenge, :challenge_actions
  end
end
