class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_email(params[:user][:email])

    flash[:notices] ||= []
    if user.verify_password?(params[:user][:password])
      session[:session_token] = user.reset_session_token!
      flash[:notices] << "You are now logged in"
      redirect_to bands_url
    else
      flash[:notices] << "Incorrect email and/or password"
      render :new
    end
  end

  def destroy
    u = current_user

    if u.nil?
      redirect_to new_session_url
      return
    end

    session[:session_token] = nil
    u.session_token = nil
    u.save!

    redirect_to new_session_url
  end
end

#     session POST   /session(.:format)                                sessions#create
#             DELETE /session(.:format)                                sessions#destroy
# new_session GET    /session/new(.:format)                            sessions#new
