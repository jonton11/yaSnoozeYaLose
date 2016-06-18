class RejectingsController < ApplicationController # :nodoc:
  before_action :authenticate_user!
  def update
    challenge = Challenge.find(params[:challenge_id])
    challenge.reject!
    redirect_to challenge_path(challenge), notice: 'Voted to Reject!'
  end
end
