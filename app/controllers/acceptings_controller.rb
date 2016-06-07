class AcceptingsController < ApplicationController # :nodoc:
  before_action :authenticate_user!
  def update
    challenge = Challenge.find(params[:challenge_id])
    challenge.accept!
    redirect_to challenge_path(challenge), notice: 'CHALLENGE ACCEPTED!'
  end
end
