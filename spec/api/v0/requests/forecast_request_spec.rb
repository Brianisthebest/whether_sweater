require 'rails_helper'

RSpec.describe 'Forecast API' do
  it 'sends a forecast for a city' do
    location = 'colorado springs,co'

    get "/api/v0/forecast?location=#{location}"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(json).to be_a(Hash)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data][:id]).to eq('null')
    expect(json[:data][:type]).to eq('forecast')
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes]).to have_key(:current_weather)
    expect(json[:data][:attributes]).to have_key(:daily_weather)
    expect(json[:data][:attributes]).to have_key(:hourly_weather)
  end

  it 'sends an error if no location is sent' do
    location = ''

    get "/api/v0/forecast?location=#{location}"

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:error]).to eq('No location provided')
  end
end