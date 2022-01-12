class ItemsController < ApplicationController
  before_action :set_item, only: [:update]

  # GET /items
  def index
    @items = Item.all

    render json: @items
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.fetch(:item, {}).permit(:code, :name, :price)
    end
end
