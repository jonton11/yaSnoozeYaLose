class ChallengesController < ApplicationController # :nodoc:
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]

  def index
    find_user_challenges
  end

  def show
    @streak_count = current_user.challenge_actions.find_by_challenge_id(params[:id]).streak_count
    @team = @challenge.team
    @challenge_action = @challenge.challenge_actions.find_by_user_id(current_user)
    # @streak_count = current_user.challenge_actions.find_by_challenge_id(params[:challenge_id]).streak_count
  end

  def new
    @challenge = Challenge.new
    set_allowed_teams
  end

  def edit
  end

  def create
    @challenge = Challenge.new(challenge_params)
    set_allowed_teams
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

  def set_allowed_teams
    @team_ids = []
    @memberships = Member.where(user_id: current_user)
    @memberships.each do |member|
      @team_ids.push(member.team_id)
    end
    @teams = Team.where(id: @team_ids)
  end

  def challenge_params
    params.require(:challenge).permit(:name, :description, :start_date, :team_id)
  end

  def create_challenge_actions
    @team = @challenge.team
    @team.users.each do |user|
      @user = user
      @actions = ChallengeAction.new(action_params)
      @challenge.challenge_actions.push(@actions)
    end
  end

  def action_params
    { challenge_id: @challenge, user_id: @user.id }
  end

  def find_user_challenges
    @challenge_ids = []
    challenge_actions = ChallengeAction.where(user_id: current_user)
    challenge_actions.each do |challenge|
      @challenge_ids.push(challenge.challenge_id)
    end
    @challenges = Challenge.all.where(id: @challenge_ids)
  end
end
