class BandsController < ApplicationController
  def index
    @bands = Band.all

    render :index
  end

  def new
    @band = Band.new

    render :new
  end

  def create
    @band = Band.new(params[:band])

    flash[:notices] ||= []
    if @band.save
      band = Band.where(params[:band]).first
      flash[:notices] << "Band #{ band.id }: #{ band.name } created"
      redirect_to bands_url
    else
      flash[:notices] << "Invalid input, please try again"
      render :new
    end
  end

  def show
    @band = Band.find(params[:id])

    render :show
  end

  def edit
    @band = Band.find(params[:id])

    render :edit
  end

  def update
    @band = Band.find(params[:id])
    @band.update_attributes(params[:band])

    flash[:notices] ||= []
    if @band.save
      flash[:notices] << "Edited Band #{ @band.id }: #{ @band.name }"
      redirect_to band_url(params[:id])
    else
      flash[:notices] << "Invalid input, please try again"
      render :edit
    end
  end

  def destroy
    band = Band.find(params[:id])

    flash[:notices] ||= []
    flash[:notices] << "Band #{ band.id }: #{ band.name } destroyed"
    band.destroy

    redirect_to bands_url
  end
end

#     bands GET    /bands(.:format)                                           bands#index
#           POST   /bands(.:format)                                           bands#create
#  new_band GET    /bands/new(.:format)                                       bands#new
# edit_band GET    /bands/:id/edit(.:format)                                  bands#edit
#      band GET    /bands/:id(.:format)                                       bands#show
#           PUT    /bands/:id(.:format)                                       bands#update
#           DELETE /bands/:id(.:format)                                       bands#destroy