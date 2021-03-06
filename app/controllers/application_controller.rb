class ApplicationController < ActionController::Base # :nodoc:
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user!
    redirect_to new_session_path, notice: 'Please Log In' unless user_signed_in?
  end

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in?

  def current_user
    @current_user ||= User.find session[:user_id] if user_signed_in?
  end
  helper_method :current_user

  def sign_in(user)
    session[:user_id] = user.id
  end

  def check_track_date
    @challenge_action.track_date.nil? || @challenge_action.track_date < Date.today
  end
  helper_method :check_track_date
end
