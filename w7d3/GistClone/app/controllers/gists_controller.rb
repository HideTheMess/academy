class GistsController < ApplicationController
  def index
    @gists = current_user.gists

    render 'index.json.rabl'
    # render json: current_user.gists
  end
end

# gists GET    /gists(.:format)                   gists#index