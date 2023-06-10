require 'rails_helper'

RSpec.describe ForecastFacade do
  it 'returns a forecast object' do
    forecast = ForecastFacade.new.get_forecast('colorado springs,co')

    expect(forecast).to be_a(Forecast)
    expect(forecast.id).to eq('null')
    expect(forecast.type).to eq('forecast')
    expect(forecast.current_weather).to be_a(Hash)
  end
end