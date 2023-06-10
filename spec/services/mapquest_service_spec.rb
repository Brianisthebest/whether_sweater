require 'rails_helper'

RSpec.describe MapquestService do
  it 'returns a hash' do
    location = 'colorado springs,co'

    response = MapquestService.new.get_lat_lng(location)
require 'pry'; binding.pry
    expect(response).to be_a(Hash)
  end
end