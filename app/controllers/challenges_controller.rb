class ChallengesController < ApplicationController # :nodoc:
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]

  def index
    find_challenge_ids
    @challenges = Challenge.all.where(id: @challenge_ids)
  end

  def show
    # user.challenge_actions.find(:challenge_id).streak_count
  end

  def new
    @challenge = Challenge.new
  end

  def edit
  end

  def create
    @challenge = Challenge.new(challenge_params)
    respond_to do |format|
      if @challenge.save
        create_challenge_actions
        format.html { redirect_to team_path(@challenge.team), notice: 'Challenge created.' }
        format.json { render :show, status: :created, location: @challenge }
      else
        format.html { render :new }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @challenge.update(challenge_params)
        format.html { redirect_to @challenge, notice: 'Challenge updated.' }
        format.json { render :show, status: :ok, location: @challenge }
      else
        format.html { render :edit }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @challenge.destroy
    respond_to do |format|
      format.html { redirect_to challenges_url, notice: 'Challenge deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  def challenge_params
    params.require(:challenge).permit(:name, :description, :start_date, :team_id)
  end

  def create_challenge_actions
    @actions = ChallengeAction.new(action_params)
    @challenge.challenge_actions.push(@actions)
  end

  def action_params
    { challenge_id: @challenge, user_id: current_user.id, streak_count: 0 }
  end

  def find_challenge_ids
    @challenge_ids = []
    challenge_actions = ChallengeAction.where(user_id: current_user)
    challenge_actions.each do |challenge|
      @challenge_ids.push(challenge.challenge_id)
    end
  end
end
