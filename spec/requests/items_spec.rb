require 'rails_helper'

RSpec.describe '/items', type: :request do
  describe 'GET /index' do
    it 'renders a successful response' do
      item = create(:item)
      get items_url, as: :json
      expect(response).to be_successful
      expect(response.body).to eq([{code: item.code, name: item.name, price: item.formatted_price}].to_json)
    end
  end

  describe 'PATCH /update' do
    let(:item) { create(:item) }

    context 'with valid parameters' do
      let(:new_attributes) { { price: 750 } }

      it 'updates the requested item' do
        patch item_url(item),
              params: { item: new_attributes }, as: :json
        item.reload
        expect(item.price).to eq(750)
      end

      it 'renders a JSON response with the item' do
        patch item_url(item),
              params: { item: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the item' do
        patch item_url(item),
              params: { item: { price: nil } }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
