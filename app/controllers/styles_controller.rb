# frozen_string_literal: true

class StylesController < ApplicationController
  before_action :set_style, only: %i[show update destroy]
  authorize_resource

  # GET /styles
  def index
    Style.page(params[:page]).then { |styles| json_response(styles) }
  end

  # GET /styles/:id
  def show
    json_response(set_style)
  end

  # POST /styles
  def create
    Style.create!(style_params).then { |style| json_response(style, :created) }
  end

  # PUT /styles/:id
  def update
    set_style.update(style_params)
    head :no_content
  end

  # DELETE /styles/:id
  def destroy
    set_style.destroy
    head :no_content
  end

  private

  def style_params
    params.permit(:name, :school_brewery, :user_id)
  end

  def set_style
    @style = Style.find(params[:id])
  end
end
