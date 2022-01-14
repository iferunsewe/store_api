require 'rails_helper'

RSpec.describe QuotesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/quotes').to route_to('quotes#index')
    end

    it 'routes to #show' do
      expect(get: '/quotes/1').to route_to('quotes#show', id: '1')
    end
    
    it 'routes to #create' do
      expect(post: '/quotes').to route_to('quotes#create')
    end
  end
end
