class UsersController < ApplicationController
  def index
    unless current_user.blank?
      redirect_to user_url(current_user.id)
    else
      redirect_to new_user_url
    end
  end

  def new
    render :new
  end

  def create
    user = User.new(params[:user])
    session[:session_token] = user.gen_token

    if user.save
      user = User.where(params[:user]).first
      redirect_to user_url(user.id)
    else
      render :new
    end
  end

  def show
    if current_user.id == params[:id].to_i
      @user = current_user
      @follows = @user.follows
      @followers = @user.followers

      render :show
    else
      redirect_to new_user_url
    end
  end

  def edit
    @user = User.find(params[:id])

    render :edit
  end

  def update
    if current_user.id == params[:id].to_i
      current_user.update_attributes(params[:user])

      if current_user.save
        redirect_to user_url
      else
        render :edit
      end
    else
      redirect_to new_user_url
    end
  end

  def destroy
    if current_user.id == params[:id].to_i
      current_user.delete

      redirect_to :index
    else
      redirect_to new_user_url
    end
  end
end

#     users GET    /users(.:format)          users#index
#           POST   /users(.:format)          users#create
#  new_user GET    /users/new(.:format)      users#new
# edit_user GET    /users/:id/edit(.:format) users#edit
#      user GET    /users/:id(.:format)      users#show
#           PUT    /users/:id(.:format)      users#update
#           DELETE /users/:id(.:format)      users#destroy