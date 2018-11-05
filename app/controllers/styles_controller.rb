class StylesController < ApplicationController
  before_action :set_style, only: %i[show update destroy]

  # GET /styles
  def index
    @styles = Style.all
    json_response(@styles)
  end

  # GET /styles/:id
  def show
    json_response(@style)
  end

  # POST /styles
  def create
    @style = Style.create!(style_params)
    json_response(@style, :created)
  end

  # PUT /styles/:id
  def update
    @style.update(style_params)
    head :no_content
  end

  # DELETE /styles/:id
  def destroy
    @style.destroy
    head :no_content
  end

  private

  def style_params
    params.permit(:name, :school_brewery)
  end

  def set_style
    @style = Style.find(params[:id])
  end
end
