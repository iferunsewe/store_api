require 'rails_helper'

RSpec.describe Quote, type: :model do
  it { should validate_presence_of(:item_codes) }

  context "when both item codes are invalid" do
    it 'invalidates the quote' do
      quote = build(:quote, item_codes: ['ITEM-1', 'ITEM-2'])
      quote.validate
      expect(quote.errors.messages[:item_codes]).to eq(['are invalid'])
    end
  end

  context "when some item codes are invalid" do
    it 'invalidates the quote' do
      create(:item, code: 'ITEM-1', name: 'Item 1', price: 1000)
      quote = build(:quote, item_codes: ['ITEM-1', 'ITEM-2'])
      quote.validate
      expect(quote.errors.messages[:item_codes]).to eq(['are invalid'])
    end
  end
  
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

  describe "#apply_discounts" do
    before do
      create(:item, code: 'A', price: 10)
      create(:item, code: 'B', price: 20)
    end

    it 'applies a bundle discount' do
      create(:discount, discount_type: 'bundle', code: 'A', min_quantity: 2)
      quote = create(:quote, item_codes: %w[A B A])
      expect(quote.total).to eq(30)
    end

    it 'applies a percentage discount' do
      create(:discount, discount_type: 'percentage', code: 'A', min_quantity: 2, discount_percentage: 10)
      quote = create(:quote, item_codes: %w[A B A])
      expect(quote.total).to eq(38)
    end

    it 'applies multiple discounts' do
      create(:discount, discount_type: 'bundle', code: 'A', min_quantity: 2)
      create(:discount, discount_type: 'percentage', code: 'A', min_quantity: 2, discount_percentage: 10)
      quote = create(:quote, item_codes: %w[A A B])
      expect(quote.total).to eq(28)
    end

    it 'applies multiple discounts with different codes' do
      create(:discount, discount_type: 'bundle', code: 'A', min_quantity: 2)
      create(:discount, discount_type: 'percentage', code: 'B', min_quantity: 2, discount_percentage: 10)
      quote = create(:quote, item_codes: %w[A A B B])
      expect(quote.total).to eq(46)
    end

    it 'does not apply a discount if the minimum quantity is not met' do
      create(:discount, discount_type: 'bundle', code: 'A', min_quantity: 3)
      quote = create(:quote, item_codes: %w[A B A])
      expect(quote.total).to eq(40)
    end
  end
end
