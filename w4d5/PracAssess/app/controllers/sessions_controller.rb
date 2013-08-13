class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.where(params[:user]).first

    if user.blank?
      render :new
      return
    end

    session[:session_token] = user.gen_token
    user.save!

    redirect_to user_url(user.id)
  end

  def destroy
  end
end

#     session POST   /session(.:format)        sessions#create
# new_session GET    /session/new(.:format)    sessions#new
#             DELETE /session(.:format)        sessions#destroy