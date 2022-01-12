require 'rails_helper'

RSpec.describe Item, type: :model do
  it "has a valid factory" do
    expect(build(:item)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:item, name: nil)).to_not be_valid
  end

  it "is invalid without a code" do
    expect(build(:item, code: nil)).to_not be_valid
  end

  it "is invalid without a price" do
    expect(build(:item, price: nil)).to_not be_valid
  end

  it "is invalid with a duplicate code" do
    create(:item, code: 'MUG')
    expect(build(:item, code: 'MUG')).to_not be_valid
  end
end
