require 'rails_helper'

RSpec.describe '/quotes', type: :request do

  before do
    create(:item, code: 'ITEM-1', name: 'Item 1', price: 1000)
    create(:item, code: 'ITEM-2', name: 'Item 2', price: 2000)
  end
  
  describe 'GET /quotes/:id' do
    it 'returns a quote' do
      quote = create(:quote, item_codes: ['ITEM-1', 'ITEM-2'])
      get "/quotes/#{quote.id}"
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq({
        item_codes: quote.item_codes,
        total: quote.formatted_total
      }.to_json)
    end
  end

  describe 'GET /quotes' do
    it 'returns a list of quotes' do
      quote = create(:quote, item_codes: ['ITEM-1', 'ITEM-2'])
      get quotes_url, as: :json

      expect(response).to be_successful
      expect(response.body).to eq([{item_codes: quote.item_codes, total: quote.formatted_total}].to_json)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let(:valid_attributes) { { item_codes: %w[ITEM-1 ITEM-2] } }

      it 'creates a new Quote' do
        expect do
          post quotes_url,
               params: { quote: valid_attributes }, as: :json
        end.to change(Quote, :count).by(1)
      end

      it 'renders a JSON response with the new quote' do
        post quotes_url,
             params: { quote: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(response.body).to eq(Quote.last.to_json)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) { { item_codes: [] } }

      it 'does not create a new quote' do
        expect do
          post quotes_url,
               params: { quote: invalid_attributes }, as: :json
        end.to change(Quote, :count).by(0)
      end

      it 'renders a JSON response with errors for the new quote' do
        post quotes_url,
             params: { quote: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
