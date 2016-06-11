class TeamsController < ApplicationController # :nodoc:
  before_action :authenticate_user!, except: :join
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    find_team_ids
    @teams = Team.where(id: @team_ids)
  end

  def show
    @challenges = []
    @team.challenges.each do |challenge|
      @challenges << challenge if challenge.accepted?
    end
  end

  def new
    @team = Team.new
  end

  def edit
  end

  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        current_user_joins_team
        format.html { redirect_to @team, notice: 'Team created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team destroyed.' }
      format.json { head :no_content }
    end
  end

  def join
    @team = Team.find_by_name(params[:search])
    if @team
      @membership = Member.new(user_id: current_user.id, team_id: @team.id)
      if @membership.save
        current_user.members << @membership
        join_challenges
        redirect_to @team, notice: "Joined #{@team.name}!"
      else
        flash[:notice] = "Failed to join #{@team.name}"
        render :join
      end
    end
  end

  def team_requests
    @request = []
    find_team_ids
    @teams = Team.where(id: @team_ids)
    @teams.each do |team|
      team.challenges.each do |challenge|
        @request << challenge if challenge.request?
      end
    end
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name)
  end

  def find_team_ids
    @team_ids = []
    @member = Member.where(user_id: current_user)
    @member.each do |mem|
      @team_ids << mem.team_id
    end
  end

  def current_user_joins_team
    @member = Member.new(team_id: @team.id, user_id: current_user.id)
    @team.members << @member
  end

  def self.search_team(search)
    if search
      find(:all, conditions: ['name LIKE ?', "%#{search.strip}"])
    else
      false
    end
  end

  def join_challenges
    @team.challenges.each do |challenge|
      challenge_action = ChallengeAction.new(challenge_id: challenge.id, user_id: current_user.id)
      current_user.challenge_actions.push(challenge_action)
    end
  end
end
