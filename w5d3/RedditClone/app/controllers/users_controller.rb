class UsersController < ApplicationController
  def new # Guest has Access
    unless logged_in?
      render :new
    else
      redirect_to user_url(current_user.id)
    end
  end

  def create # Guest has Access
    user = User.new(params[:user])
    user.reset_session_token

    if user.save
      session[:token] = user.session_token

      flash[:notices] ||= []
      flash[:notices] << "Thanks for signing up, #{ user.username }!"
      redirect_to user_url(user.id)
    else
      flash.now[:notices] ||= []
      flash.now[:notices] << "Username / Password can't be blank"
      render :new
    end
  end

  def show # User has Access
    user = User.find(params[:id])

    if current_user == user
      @subs = user.modded_subs
      @links = user.authored_links

      render :show
    else
      flash[:notices] ||= []
      flash[:notices] << "Not your profile page"
      redirect_to new_session_url
    end
  end
end

#    users POST   /users(.:format)       users#create
# new_user GET    /users/new(.:format)   users#new
#     user GET    /users/:id(.:format)   users#show