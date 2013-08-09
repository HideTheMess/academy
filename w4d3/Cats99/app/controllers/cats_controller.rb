class CatsController < ApplicationController
  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find(params[:id])
  end

  # def new
  # end

  def create
    params[:cat][:birth_date] = Date.parse(params[:cat][:birthdate])
    params[:cat].delete(:birthdate)
    Cat.create!(params[:cat])

    redirect_to root_url
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def update
    params[:cat][:birth_date] = Date.parse(params[:cat][:birthdate])
    params[:cat].delete(:birthdate)
    cat = Cat.update(params[:id], params[:cat])

    redirect_to cat_url(cat)
  end

  def destroy
    Cat.delete(params[:id])

    redirect_to root_url
  end
end
