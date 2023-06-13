require 'rails_helper'

RSpec.describe MapquestService do
  describe 'get_lat_lng' do
    it 'returns a hash' do
      location = 'colorado springs,co'
  
      response = MapquestService.new.get_lat_lng(location)
  
      expect(response).to be_a(Hash)
      expect(response[:results][0][:locations][0][:latLng][:lat]).to eq(38.83352)
      expect(response[:results][0][:locations][0][:latLng][:lng]).to eq(-104.82181)
    end
  end

  describe 'get_directions' do
    it 'returns a hash' do
      origin = 'new york, ny'
      destination = 'los angeles, ca'

      response = MapquestService.new.get_directions(origin, destination)

      expect(response).to be_a(Hash)
      expect(response[:route][:locations][0][:adminArea5]).to eq('New York')
      expect(response[:route][:locations][1][:adminArea5]).to eq('Los Angeles')
    end
  end
end