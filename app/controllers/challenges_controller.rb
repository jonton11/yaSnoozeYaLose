class ChallengesController < ApplicationController # :nodoc:
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]

  def index
    find_user_challenges
  end

  def show
    @total_streak = current_user.challenge_actions.find_by_challenge_id(params[:id]).try(:total_streak) || 0
    @team = @challenge.team
    @challenge_action = @challenge.challenge_actions.find_by_user_id(current_user)
    calculate_average_streak
    calculate_leading_player
    gon_variables
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

  def vote
    @challenge = Challenge.find(params[:id])
    @challenge_action = @challenge.challenge_actions.find_by_user_id(current_user)
    @vote = @challenge_action.vote
    @challenge_action.vote = !@vote if @vote == false
    if @challenge_action.save
      check_accepted
      redirect_to request_teams_path(@challenge.team), notice: "VOTED TO ACCEPT CHALLENGE: #{@challenge.name}"
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
      @team_ids << member.team_id
    end
    @teams = Team.where(id: @team_ids)
  end

  def challenge_params
    params.require(:challenge).permit(:name, :description, :start_date, :team_id, :reward)
  end

  def create_challenge_actions
    @team = @challenge.team
    @team.users.each do |user|
      @user = user
      @actions = ChallengeAction.new(action_params)
      @challenge.challenge_actions << @actions
    end
  end

  def action_params
    { challenge_id: @challenge, user_id: @user.id }
  end

  def find_user_challenges
    @challenge_ids = []
    challenge_actions = ChallengeAction.where(user_id: current_user)
    challenge_actions.each do |challenge|
      @challenge_ids << challenge.challenge_id
    end
    @challenges = Challenge.all.where(id: @challenge_ids)
  end

  def calculate_average_streak
    @total_count = 0
    @team.users.each do |user|
      user.challenge_actions.reload
      @total_count += user.challenge_actions.find_by_challenge_id(@challenge).try(:total_streak) || 0
    end
    @avg_streak = @total_count.to_f / @team.users.count.to_f
  end

  def calculate_leading_player
    @max_streak = 0
    @team.users.each do |user|
      @count = user.challenge_actions.find_by_challenge_id(@challenge).try(:total_streak) || 0
      if @count > @max_streak
        @max_streak = @count
        @leading_player = user
      end
    end
  end

  def check_accepted
    true_votes = 0
    @team = @challenge.team
    @team.challenges.find_by_id(@challenge).challenge_actions.each do |user|
      true_votes = true_votes + 1 if (user.vote == true)
    end
    @challenge.accept! if (true_votes * 2) > @team.users.count
  end

  def gon_variables
    gon.total_streak = @total_streak
    gon.challenge = @challenge
    gon.team = @team
    gon.users = []
    @team.users.each_with_index do |user, index|
      gon.users.push({index => [user.full_name , (user.challenge_actions.find_by_challenge_id(@challenge).try(:total_streak) || 0)]})
    end
    gon.challenge_action = @challenge_action
  end
end
