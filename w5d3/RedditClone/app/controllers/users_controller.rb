class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.new(params[:user])
    user.reset_session_token

    if user.save
      session[:token] = user.session_token

      rendirect_to user_url(user.id)
    else
      render :new
    end
  end

  def show
    if current_user.id == params[:id]
      render :show
    else
      redirect_to new_session_url
    end
  end
end

#    users POST   /users(.:format)       users#create
# new_user GET    /users/new(.:format)   users#new
#     user GET    /users/:id(.:format)   users#show