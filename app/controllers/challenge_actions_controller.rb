class ChallengeActionsController < ApplicationController # :nodoc:
  before_action :find_challenge
  before_action :find_user
  before_action :find_challenge_action

  def update
    # Have simply a completed button?
    # Can we track what day they pressed the button?
    @challenge_action.streak_count = @streak + 1
    if @challenge_action.track_date != Date.today
      @challenge_action.track_date = Date.today
      @challenge_action.save
      redirect_to challenge_path(@challenge), notice: 'Keep it up!'
    else
      redirect_to challenge_path(@challenge), alert: 'Already tracked today!'
    end
  end

  private

  def find_challenge
    @challenge = Challenge.find(params[:challenge_id])
  end

  def find_user
    @user = current_user
  end

  def find_challenge_action
    @challenge_action = @challenge.challenge_actions.find_by_user_id(@user)
    @streak = @challenge_action.streak_count
  end
end
