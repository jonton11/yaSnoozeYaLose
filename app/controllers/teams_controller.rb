class TeamsController < ApplicationController # :nodoc:
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = Team.all
    Member.where(user_id: current_user)
    @member = Member.where(user_id: current_user)
    Team.where(id: @member)
  end

  def show
    # @challenges = Challenge.all.where(team_id: current_team)
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
        # If the team is saved, create an association between the Team and User
        # Must associate both ways because of Many-To-Many
        @members = Member.new(team_id: @team.id, user_id: current_user.id)
        @team.members.push(@members)
        # Associate the current user with the team just created
        current_user.team_id = @team.id
        current_user.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
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
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
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
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
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
end
