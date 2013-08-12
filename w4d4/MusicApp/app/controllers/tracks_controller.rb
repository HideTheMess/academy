class TracksController < ApplicationController
  def index
    @tracks = Track.where(album_id: params[:album_id])

    render :index
  end


  def new
    @track = Track.new

    render :new
  end

  def create
    @track = Track.new(params[:track])

    flash[:notices] ||= []
    if @track.save
      track = Track.where(params[:track]).first
      flash[:notices] <<
                      "Track #{ track.id }: #{ track.name } created"
      redirect_to band_album_tracks_url(track.album.band_id, track.album_id)
    else
      flash[:notices] << "Invalid input, please try again"
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])

    render :show
  end

  def edit
    @track = Track.find(params[:id])

    render :edit
  end

  def update
    @track = Track.find(params[:id])
    @track.update_attributes(params[:track])

    flash[:notices] ||= []
    if @track.save
      flash[:notices] <<
                      "Edited Track #{ @track.id }: #{ @track.name }"
      redirect_to track_url
    else
      flash[:notices] << "Invalid input, please try again"
      render :edit
    end
  end

  def destroy
    track = Track.find(params[:id])

    flash[:notices] ||= []
    flash[:notices] << "Track #{ track.id }: #{ track.name } destroyed"
    redirect_to band_album_tracks_url(track.album.band_id, track.album_id)

    track.destroy
  end
end

# band_album_tracks GET    /bands/:band_id/albums/:album_id/tracks(.:format) tracks#index
#            tracks POST   /tracks(.:format)                                 tracks#create
#         new_track GET    /tracks/new(.:format)                             tracks#new
#        edit_track GET    /tracks/:id/edit(.:format)                        tracks#edit
#             track GET    /tracks/:id(.:format)                             tracks#show
#                   PUT    /tracks/:id(.:format)                             tracks#update
#                   DELETE /tracks/:id(.:format)                             tracks#destroy