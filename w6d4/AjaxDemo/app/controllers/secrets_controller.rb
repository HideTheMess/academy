class SecretsController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :index }
      format.json { render :json => Secret.all }
    end
  end

  def new
    @user = User.find(params[:user_id])

    render :new
  end

  def create
    @secret = Secret.create!(params[:secret])
    @user = User.find(params[:user_id])

    render template: 'users/show'
  end
end

#         secrets GET    /secrets(.:format)                    secrets#index
#     edit_secret GET    /secrets/:id/edit(.:format)           secrets#edit
#          secret GET    /secrets/:id(.:format)                secrets#show
#                 PUT    /secrets/:id(.:format)                secrets#update
#                 DELETE /secrets/:id(.:format)                secrets#destroy
#    user_secrets POST   /users/:user_id/secrets(.:format)     secrets#create
# new_user_secret GET    /users/:user_id/secrets/new(.:format) secrets#new