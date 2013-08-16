class LinksController < ApplicationController
  def new # User has Access
  end

  def create # User has Access
  end

  def show # Guest has Access
    @link = Link.find(params[:id])

    render :show
  end

  def edit # User has Access
  end

  def update # User has Access
  end
end

#     links POST   /links(.:format)          links#create
#  new_link GET    /links/new(.:format)      links#new
# edit_link GET    /links/:id/edit(.:format) links#edit
#      link GET    /links/:id(.:format)      links#show
#           PUT    /links/:id(.:format)      links#update