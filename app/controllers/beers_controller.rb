class BeersController < ApplicationController
  before_action :set_beer, only: %i[show update destroy]

  # GET /beers
  def index
    @beers = Beer.all
    json_response(@beers)
  end

  # GET /beers/:id
  def show
    json_response(@beer)
  end

  # POST /beers
  def create
    @beer = Beer.create!(beer_params)
    json_response(@beer, :created)
  end

  # PUT /beers/:id
  def update
    @beer.update(beer_params)
    head :no_content
  end

  # DELETE /beers/:id
  def destroy
    @beer.destroy
    head :no_content
  end

  private

  def beer_params
    params.permit(:name, :style_id, :abv, :ibu, :nationality, :brewery, :description)
  end

  def set_beer
    @beer = Beer.find(params[:id])
  end
end
