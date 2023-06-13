require 'rails_helper'

RSpec.describe Forecast do
  describe 'intialize' do
    it 'exists and has attributes', :vcr do
      forecast = ForecastFacade.new.get_forecast('colorado springs,co')

      expect(forecast).to be_a(Forecast)
      expect(forecast.id).to eq('null')
      expect(forecast.type).to eq('forecast')

      # current weather
      expect(forecast.current_weather).to be_a(Hash)
      expect(forecast.current_weather).to have_key(:last_updated)
      expect(forecast.current_weather).to have_key(:temperature)
      expect(forecast.current_weather).to have_key(:feels_like)
      expect(forecast.current_weather).to have_key(:humidity)
      expect(forecast.current_weather).to have_key(:uvi)
      expect(forecast.current_weather).to have_key(:visibility)
      expect(forecast.current_weather).to have_key(:condition)
      expect(forecast.current_weather).to have_key(:icon)
      expect(forecast.current_weather).to_not have_key(:region)
      expect(forecast.current_weather).to_not have_key(:country)

      # daily weather
      expect(forecast.daily_weather).to be_an(Array)
      expect(forecast.daily_weather.count).to eq(5)
      expect(forecast.daily_weather.first).to be_a(Hash)
      expect(forecast.daily_weather.first).to have_key(:date)
      expect(forecast.daily_weather.first).to have_key(:sunrise)
      expect(forecast.daily_weather.first).to have_key(:sunset)
      expect(forecast.daily_weather.first).to have_key(:max_temp)
      expect(forecast.daily_weather.first).to have_key(:min_temp)
      expect(forecast.daily_weather.first).to have_key(:condition)
      expect(forecast.daily_weather.first).to have_key(:icon)

      # hourly weather
      expect(forecast.hourly_weather).to be_an(Array)
      expect(forecast.hourly_weather.count).to eq(24)
      expect(forecast.hourly_weather.first).to be_a(Hash)
      expect(forecast.hourly_weather.first).to have_key(:time)
      expect(forecast.hourly_weather.first).to have_key(:temperature)
      expect(forecast.hourly_weather.first).to have_key(:conditions)
      expect(forecast.hourly_weather.first).to have_key(:icon)
      expect(forecast.hourly_weather.first).to_not have_key(:is_day)
      expect(forecast.hourly_weather.first).to_not have_key(:wind_mph)
      expect(forecast.hourly_weather.first).to_not have_key(:humidity)
    end
  end
end