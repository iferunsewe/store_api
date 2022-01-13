require 'rails_helper'

RSpec.describe Discount, type: :model do
  it { should validate_presence_of(:discount_type) }
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:min_quantity) }

  describe '#apply' do
    before do
      create(:item, code: 'A', price: 10)
      create(:item, code: 'B', price: 20)
    end

    it 'applies a bundle discount' do
      discount = create(:discount, discount_type: 'bundle', code: 'A', min_quantity: 2)
      expect(discount.apply(amount: 40, item_codes: %w[A B A])).to eq(30)
    end

    it 'applies a percentage discount' do
      discount = create(:discount, discount_type: 'percentage', code: 'A', min_quantity: 2, discount_percentage: 10)
      expect(discount.apply(amount: 40, item_codes: %w[A B A])).to eq(38)
    end

    it 'returns the original amount if the item does not exist' do
      discount = create(:discount, discount_type: 'bundle', code: 'X', min_quantity: 2)
      expect(discount.apply(amount: 10, item_codes: %w[X X A])).to eq(10)
    end
  end
end
