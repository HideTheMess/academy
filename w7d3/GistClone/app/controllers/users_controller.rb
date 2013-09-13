class UsersController < ApplicationController
  before_filter :require_no_current_user!, :only => [:create, :new]

  def create
    @user = User.new(params[:user])

    if @user.save
      self.current_user = @user
      redirect_to root_url
    else
      render :json => @user.errors.full_messages
    end
  end

  def new
    @user = User.new
  end
end

#    users POST   /users(.:format)                   users#create
# new_user GET    /users/new(.:format)               users#new