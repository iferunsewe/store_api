require 'rails_helper'

RSpec.describe Quote, type: :model do
  it { should validate_presence_of(:item_codes) }

  it 'updates subtotal after saving' do
    create(:item, code: 'MUG', price: 10)
    quote = create(:quote, item_codes: %w[MUG MUG])
    expect(quote.subtotal).to eq(Item.find_by(code: 'MUG').price * 2)
  end

  it 'updates total after saving' do
    create(:item, code: 'MUG', price: 10)
    quote = create(:quote, item_codes: %w[MUG MUG])
    expect(quote.total).to eq(quote.subtotal)
  end
end
