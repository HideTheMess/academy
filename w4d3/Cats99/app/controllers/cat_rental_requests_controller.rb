class CatRentalRequestsController < ApplicationController
  def index
    @requests = CatRentalRequest.all
  end

  def new
    @cats = Cat.all
  end

  def create
    params[:cat_rental_request][:cat_id] =
      params[:cat_rental_request][:catid].to_i
    params[:cat_rental_request].delete(:catid)

    params[:cat_rental_request][:begin_date] =
      Date.parse(params[:cat_rental_request][:begindate])
    params[:cat_rental_request].delete(:begindate)

    params[:cat_rental_request][:end_date] =
      Date.parse(params[:cat_rental_request][:enddate])
    params[:cat_rental_request].delete(:enddate)

    CatRentalRequest.create!(params[:cat_rental_request])

    cat = Cat.find(params[:cat_rental_request][:cat_id])
    redirect_to cat_url(cat)
  end
end
