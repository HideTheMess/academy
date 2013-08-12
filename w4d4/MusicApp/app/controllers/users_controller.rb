class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.new(params[:user])

    flash[:notices] ||= []
    if user.save
      user = User.find_by_email(params[:user][:email])
      # msg = UserMailer.welcome_email(user, new_session_url)
#       msg.deliver!
      flash[:notices] << "User #{ user.email } created"
      redirect_to new_session_url
    else
      flash[:notices] << "Invalid input, please try again"
      render :new
    end
  end
end

#    users POST   /users(.:format)                                  users#create
# new_user GET    /users/new(.:format)                              users#new