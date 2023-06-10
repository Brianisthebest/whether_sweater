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
  end
end