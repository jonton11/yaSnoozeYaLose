module ChallengeActionsHelper
  def check_track_date
    @challenge_action.track_date.nil? || @challenge_action.track_date <= Date.today
  end
end
