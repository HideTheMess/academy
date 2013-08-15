class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_username(params[:user][:username])

    unless user.blank? || !( user.authenticated?(params[:user][:password]) )
      session[:token] = user.reset_session_token
      user.save

      redirect_to user_url(user.id)
    else
      render :new
    end
  end

  def destroy
    current_user.reset_session_token
    session[:token] = nil

    redirect_to new_session_url
  end
end

#     session POST   /session(.:format)     sessions#create
# new_session GET    /session/new(.:format) sessions#new
#             DELETE /session(.:format)     sessions#destroy