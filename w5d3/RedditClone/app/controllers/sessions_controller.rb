class SessionsController < ApplicationController
  def new # Guest has Access
    unless logged_in?
      render :new
    else
      redirect_to user_url(current_user.id)
    end
  end

  def create # User has Access
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

  def destroy # User has Access
    unless current_user.blank?
      flash[:notices] ||= []
      flash[:notices] << "#{ current_user.username } is now logged out"

      current_user.reset_session_token
    end

    session[:token] = nil

    redirect_to new_session_url
  end
end

#     session POST   /session(.:format)     sessions#create
# new_session GET    /session/new(.:format) sessions#new
#             DELETE /session(.:format)     sessions#destroy