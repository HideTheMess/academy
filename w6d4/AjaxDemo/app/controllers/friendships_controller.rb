class FriendshipsController < ApplicationController
  def create
    sleep(2)
    @friendship = Friendship.create!(params[:friendship])
    @users = User.all

    # render template: 'users/index'
    # respond_to do |format|
#       format.html { redirect_to users_url }
#       format.json { render json: @friendship }
#     end
    render json: @friendship
  end

  def destroy
    sleep(2)
    @friendship = Friendship.where(params[:friendship])[0]
    @friendship.delete
    @users = User.all

    # render template: 'users/index'
    render json: @friendship
  end
end

# user_friendship POST   /users/:user_id/friendship(.:format)  friendships#create
#                 DELETE /users/:user_id/friendship(.:format)  friendships#destroy