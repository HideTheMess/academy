class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_username(params[:user][:username])

    unless user.blank? || !( user.authenticated?(params[:user][:password]) )
      session[:token] = user.reset_session_token
      user.save

      flash[:notices] ||= []
      flash[:notices] << "You are now logged in as #{ user.username }"
      redirect_to user_url(user.id)
    else
      flash.now[:notices] ||= []
      flash.now[:notices] << "Invalid Username / Password"
      render :new
    end
  end

  def destroy
    user = current_user
    current_user.reset_session_token
    session[:token] = nil

    flash[:notices] ||= []
    flash[:notices] << "#{ user.username } is now logged out"
    redirect_to new_session_url
  end
end

#     session POST   /session(.:format)     sessions#create
# new_session GET    /session/new(.:format) sessions#new
#             DELETE /session(.:format)     sessions#destroy