require 'rails_helper'

RSpec.describe WeatherService do
  it 'returns a hash' do
    lat = 38.83352
    lng = -104.82181

    response = WeatherService.new.get_weather(lat, lng)

    expect(response).to be_a(Hash)
  end
end