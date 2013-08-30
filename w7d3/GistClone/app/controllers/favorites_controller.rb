class FavoritesController < ApplicationController
  def create
  end

  def destroy
  end
end

# gist_favorite POST   /gists/:gist_id/favorite(.:format) favorites#create
#               DELETE /gists/:gist_id/favorite(.:format) favorites#destroy
    # favorites GET    /favorites(.:format)               favorites#index