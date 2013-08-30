class GistsController < ApplicationController
  def index
    render json: Gist.where(owner_id: current_user.id)
  end
end

# gists GET    /gists(.:format)                   gists#index