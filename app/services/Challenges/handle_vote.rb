class Challenges::HandleVote # :nodoc:

  include Virtus.model

  attribute :challenge_action, ChallengeAction
  attribute :challenge,        Challenge
  attribute :vote,             Boolean
  attribute :user,             User

  def call
    create_challenge_actions && create_vote && vote_accept
  end

  private

  def create_challenge_actions
    @challenge_action = @challenge.challenge_actions.find_by_user_id(current_user)
  end

  def create_vote
    @vote = @challenge_action.vote
  end

  def vote_accept
    @challenge_action.vote = !@vote if @vote == false
  end
end
