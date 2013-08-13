class FollowingsController < ApplicationController
  def index
    unless current_user.blank?
      @users = User.all
      @follows = current_user

      render :index
    else
      redirect_to new_user_url
    end
  end
end
