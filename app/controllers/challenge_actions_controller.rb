class ChallengeActionsController < ApplicationController # :nodoc:
  before_action :find_challenge
  before_action :find_user

  def update
    # Have simply a completed button?
    # Can we track what day they pressed the button?
    # @challenge.challenge_actions.find_by_user_id(@user).streak_count+=1
    # @challenge.challenge_actions.save
  end

  private

  def find_challenge
    @challenge = Challenge.find(params[:id])
  end

  def find_user
    @user = current_user
  end
end
