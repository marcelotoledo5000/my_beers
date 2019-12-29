# frozen_string_literal: true

class PubsController < ApplicationController
  before_action :set_pub, only: %i[show update destroy]
  authorize_resource

  # GET /pubs
  def index
    Pub.page(params[:page]).then { |pubs| json_response(pubs) }
  end

  # GET /pubs/:id
  def show
    json_response(@pub)
  end

  # POST /pubs
  def create
    Pub.create!(pub_params).then { |pub| json_response(pub, :created) }
  end

  # PUT /pubs/:id
  def update
    @pub.update(pub_params)
    head :no_content
  end

  # DELETE /pubs/:id
  def destroy
    @pub.destroy
    head :no_content
  end

  private

  def pub_params
    params.permit(:name, :country, :state, :city, :user_id)
  end

  def set_pub
    @pub = Pub.find(params[:id])
  end
end
