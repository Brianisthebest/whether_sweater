require 'rails_helper'

RSpec.describe WeatherService do
  describe 'get_weather' do
    it 'returns a hash' do
      lat = 38.83352
      lng = -104.82181
  
      response = WeatherService.new.get_weather(lat, lng)
  
      expect(response).to be_a(Hash)
    end
  end

  # describe 'get_future_weather' do
  #   it 'returns a hash' do
  #     lat = 38.83352
  #     lon = -104.82181
  #     dt = "2023-07-09".to_time
  #     hour = 12

  #     response = WeatherService.new.get_future_weather(lat, lon, dt, hour)

  #     expect(response).to be_a(Hash)
  #   end
  # end
end