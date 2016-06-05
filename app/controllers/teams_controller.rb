class TeamsController < ApplicationController # :nodoc:
  before_action :authenticate_user!
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    find_team_ids
    @teams = Team.where(id: @team_ids)
  end

  def show
    @challenges = @team.challenges
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
      @team_ids.push(mem.team_id)
    end
  end

  def current_user_joins_team
    # If the team is saved, create an association between the Team and the
    # User that created that team. Other users can join the team via Members
    # Controller
    # Must associate both ways because of Many-To-Many
    @member = Member.new(team_id: @team.id, user_id: current_user.id)
    @team.members.push(@member)
    # Associate the current user with the team just created
  end
end
