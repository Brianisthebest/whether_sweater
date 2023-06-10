require 'rails_helper'

RSpec.describe MapquestService do
  it 'returns a hash' do
    location = 'colorado springs,co'

    response = MapquestService.new.get_lat_lng(location)

    expect(response).to be_a(Hash)
    expect(response[:results][0][:locations][0][:latLng][:lat]).to eq(38.83352)
    expect(response[:results][0][:locations][0][:latLng][:lng]).to eq(-104.82181)
  end
end