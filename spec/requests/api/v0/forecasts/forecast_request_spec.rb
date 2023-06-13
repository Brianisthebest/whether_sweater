require 'rails_helper'

RSpec.describe 'Forecast API' do
  it 'sends a forecast for a city', :vcr do
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
    expect(json[:data][:attributes][:current_weather]).to be_a(Hash)
    expect(json[:data][:attributes][:current_weather]).to have_key(:last_updated)
    expect(json[:data][:attributes][:current_weather]).to have_key(:temperature)
    expect(json[:data][:attributes][:current_weather]).to have_key(:feels_like)
    expect(json[:data][:attributes][:current_weather]).to have_key(:humidity)
    expect(json[:data][:attributes][:current_weather]).to have_key(:uvi)
    expect(json[:data][:attributes][:current_weather]).to have_key(:visibility)
    expect(json[:data][:attributes][:current_weather]).to have_key(:condition)
    expect(json[:data][:attributes][:current_weather]).to have_key(:icon)

    expect(json[:data][:attributes]).to have_key(:daily_weather)
    expect(json[:data][:attributes][:daily_weather]).to be_an(Array)
    expect(json[:data][:attributes][:daily_weather][0]).to be_a(Hash)
    expect(json[:data][:attributes][:daily_weather][0]).to have_key(:date)
    expect(json[:data][:attributes][:daily_weather][0]).to have_key(:sunrise)
    expect(json[:data][:attributes][:daily_weather][0]).to have_key(:sunset)
    expect(json[:data][:attributes][:daily_weather][0]).to have_key(:max_temp)
    expect(json[:data][:attributes][:daily_weather][0]).to have_key(:min_temp)
    expect(json[:data][:attributes][:daily_weather][0]).to have_key(:condition)
    expect(json[:data][:attributes][:daily_weather][0]).to have_key(:icon)

    expect(json[:data][:attributes]).to have_key(:hourly_weather)
    expect(json[:data][:attributes][:hourly_weather]).to be_an(Array)
    expect(json[:data][:attributes][:hourly_weather][0]).to be_a(Hash)
    expect(json[:data][:attributes][:hourly_weather][0]).to have_key(:time)
    expect(json[:data][:attributes][:hourly_weather][0]).to have_key(:temperature)
    expect(json[:data][:attributes][:hourly_weather][0]).to have_key(:conditions)
    expect(json[:data][:attributes][:hourly_weather][0]).to have_key(:icon)
  end

  it 'sends an error if no location is sent', :vcr do
    location = ''

    get "/api/v0/forecast?location=#{location}"

    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:error]).to eq('No location provided')
  end
end