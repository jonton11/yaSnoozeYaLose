class ChallengeActionsController < ApplicationController # :nodoc:
  before_action :find_challenge
  before_action :find_user
  before_action :find_challenge_action

  def update
    if @challenge_action.track_date != Date.today
      @challenge_action.track_date = Date.today
      check_streak
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

  def check_streak
    if @challenge_action.streak_events.count == 0
      @streak_event = StreakEvent.new(on_streak: true, challenge_action_id: @challenge_action)
      @streak = 0
      @streak += 1
    elsif streak_busted?
      @streak_event = StreakEvent.new(on_streak: false, challenge_action_id: @challenge_action)
      @streak = 1
    else
      @streak_event = StreakEvent.new(on_streak: true, challenge_action_id: @challenge_action)
      @streak += 1
    end
    @challenge_action.total_streak += 1
    @streak_event.total_streak = @challenge_action.total_streak
    if @streak_event.save
      @challenge_action.streak_events << @streak_event
    end
  end

  def streak_busted?
    @last_tracked = @challenge_action.streak_events.last.created_at.to_date
    Date.today > @last_tracked.tomorrow ? true : false
  end
end
