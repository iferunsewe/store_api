class QuotesController < ApplicationController
  # POST /quotes
  def create
    @quote = Quote.new(quote_params)

    if @quote.save
      render json: {item_codes: @quote.item_codes, total: @quote.total}, status: :created, location: @quote
    else
      render json: @quote.errors, status: :unprocessable_entity
    end
  end

  private

  def quote_params
    params.fetch(:quote, {}).permit(item_codes: [])
  end
end
