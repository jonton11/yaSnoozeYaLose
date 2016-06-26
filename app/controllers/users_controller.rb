class UsersController < ApplicationController # :nodoc:
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_challenges_and_actions, only: [:show]

  def show
    set_challenges_and_actions
    @total_streaks, @date_labels = [], []
    # TODO: Need an object to store all challenges and associated streak/created_at
    # @challenges = {Challenge1: {total_streak: X, created_at: Y}, Challenge2: {total_streak: X, created_at: Y}} etc.
    @challenge_actions.each do |challenge|
      challenge.streak_events.each do |event|
        @total_streaks << event.total_streak
        @date_labels << event.created_at.strftime('%Y/%m/%d')
      end
    end
    generate_chart_data
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        sign_in(@user)
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Account created!' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Account deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_challenges_and_actions
    @challenges = Challenge.where(challenge_action_id: @challenge_actions)
    @challenge_actions = ChallengeAction.where(user_id: current_user)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def generate_chart_data
    @options = { id: 'user-streak', width: 600, height: 400 }
    @data = {
      labels: @date_labels,
      datasets: [
        {
          label:           "Current Streak for #{current_user.full_name}",
          backgroundColor: 'rgba(220,220,220,0.2)',
          # borderColor:     'rgba(220,220,220,1)',
          data:            @total_streaks
        }
      ]
    }
  end
end
