class QuotesController < ApplicationController
  # GET /quotes/1
  def show
    @quote = Quote.find(params[:id])
    
    render json: {item_codes: @quote.item_codes, total: @quote.formatted_total}
  end

  # GET /quotes
  def index
    @quotes ||= Quote.all.map{ |quote| { item_codes: quote.item_codes, total: quote.formatted_total } }

    render json: @quotes
  end

  # POST /quotes
  def create
    @quote = Quote.new(quote_params)

    if @quote.save
      render json: @quote, status: :created, location: @quote
    else
      render json: @quote.errors, status: :unprocessable_entity
    end
  end

  private

  def quote_params
    params.fetch(:quote, {}).permit(item_codes: [])
  end
end
