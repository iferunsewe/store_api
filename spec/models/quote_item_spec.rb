require 'rails_helper'

RSpec.describe QuoteItem, type: :model do
  it { should belong_to(:quote) }
  it { should belong_to(:item) }
end
