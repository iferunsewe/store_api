class ItemsController < ApplicationController
  before_action :set_item, only: [:update]

  # GET /items
  def index
    @items ||= Item.all.map{|item| {code: item.code, name: item.name, price: item.formatted_price}}

    render json: @items
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: {code: @item.code, name: @item.name, price: @item.formatted_price}, status: :ok, location: @item
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
