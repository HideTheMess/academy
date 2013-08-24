class UsersController < ApplicationController
  before_filter :require_current_user!, :except => [:create, :new]

  def index
    @users = User.all
    @friendships = Friendship.where(user_id: current_user.id)

    render :index
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      self.current_user = @user
      redirect_to user_url(@user)
    else
      render :json => @user.errors.full_messages
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end
end

#     users GET    /users(.:format)                      users#index
#           POST   /users(.:format)                      users#create
#  new_user GET    /users/new(.:format)                  users#new
# edit_user GET    /users/:id/edit(.:format)             users#edit
#      user GET    /users/:id(.:format)                  users#show
#           PUT    /users/:id(.:format)                  users#update
#           DELETE /users/:id(.:format)                  users#destroy