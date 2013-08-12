class AlbumsController < ApplicationController
  def index
    @albums = Album.where(band_id: params[:band_id])

    render :index
  end


  def new
    @album = Album.new

    render :new
  end

  def create
    @album = Album.new(params[:album])

    flash[:notices] ||= []
    if @album.save
      album = Album.where(params[:album]).first
      flash[:notices] << "Album #{ album.id }: #{ album.name } created"
      redirect_to band_albums_url(params[:album][:band_id])
    else
      flash[:notices] << "Invalid input, please try again"
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])

    render :show
  end

  def edit
    @album = Album.find(params[:id])

    render :edit
  end

  def update
    @album = Album.find(params[:id])
    @album.update_attributes(params[:album])

    flash[:notices] ||= []
    if @album.save
      flash[:notices] << "Edited Album #{ @album.id }: #{ @album.name }"
      redirect_to album_url(params[:id])
    else
      flash[:notices] << "Invalid input, please try again"
      render :edit
    end
  end

  def destroy
    album = Album.find(params[:id])

    flash[:notices] ||= []
    flash[:notices] << "Album #{ album.id }: #{ album.name } destroyed"
    redirect_to band_albums_url(album.band_id)

    album.destroy
  end
end

# band_albums GET    /bands/:band_id/albums(.:format)                  albums#index
#      albums POST   /albums(.:format)                                 albums#create
#   new_album GET    /albums/new(.:format)                             albums#new
#  edit_album GET    /albums/:id/edit(.:format)                        albums#edit
#       album GET    /albums/:id(.:format)                             albums#show
#             PUT    /albums/:id(.:format)                             albums#update
#             DELETE /albums/:id(.:format)                             albums#destroy
