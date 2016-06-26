module UsersHelper # :nodoc:
  def display_user_email
    @user.email || 'N/A'
  end
end
