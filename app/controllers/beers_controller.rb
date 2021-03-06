# frozen_string_literal: true

class BeersController < ApplicationController
  before_action :set_beer, only: %i[show update destroy]
  authorize_resource

  # GET /beers
  def index
    Beer.page(params[:page]).then { |beers| json_response(beers) }
  end

  # GET /beers/:id
  def show
    json_response(set_beer)
  end

  # POST /beers
  def create
    Beer.create!(beer_params).then { |beer| json_response(beer, :created) }
  end

  # PUT /beers/:id
  def update
    set_beer.update(beer_params)
    head :no_content
  end

  # DELETE /beers/:id
  def destroy
    set_beer.destroy
    head :no_content
  end

  private

  def beer_params
    params.permit(:name, :style_id, :abv, :ibu, :nationality, :brewery,
                  :description, :user_id)
  end

  def set_beer
    @beer = Beer.find(params[:id])
  end
end
