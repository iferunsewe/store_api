require 'rails_helper'

RSpec.describe Quote, type: :model do
  it { should have_many(:items) }
  it { should have_many(:quote_items) }
end
