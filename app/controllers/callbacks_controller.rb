class CallbacksController < ApplicationController # :nodoc:
  def twitter
    # binding.pry
    user = User.find_or_create_with_twitter request.env['omniauth.auth']
    session[:user_id] = user.id
    redirect_to root_path, notice: 'Thank you for signing in with Twitter'
  end
end
