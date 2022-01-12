class QuotesController < ApplicationController
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
