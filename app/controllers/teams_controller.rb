class TeamsController < ApplicationController # :nodoc:
  before_action :authenticate_user!
  before_action :set_team, only: [:show, :edit, :update, :destroy, :team_requests]

  def index
    find_team_ids
    @teams = Team.where(id: @team_ids)
  end

  def show
    # @challenges = @team.challenges
    # When states are implemented
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
      respond_to do |format|
        if @membership.save
          current_user.members << @membership
          format.html { redirect_to @team, notice: 'Team updated.' }
          format.json { render :show, status: :ok, location: @team }
        else
          format.html { render :join }
          format.json { render json: @team.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def team_requests
    @request = []
    @team.challenges.each do |challenge|
      @request << challenge if challenge.request?
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
    # If the team is saved, create an association between the Team and the
    # User that created that team. Other users can join the team via Members
    # Controller
    # Must associate both ways because of Many-To-Many
    @member = Member.new(team_id: @team.id, user_id: current_user.id)
    @team.members << @member
    # Associate the current user with the team just created
  end

  def self.search_team(search)
    if search
      find(:all, conditions: ['name LIKE ?', "%#{search}"])
    else
      false
    end
  end
end
