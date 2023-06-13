require 'rails_helper'

RSpec.describe 'Road trip API' do
  describe 'POST /api/v0/road_trip', :vcr do
    it 'returns a road trip object if credentials are correct' do
      user = create(:user)
      create(:user)
      create(:user)
      
      road_trip_params = {
        "origin": "new york, ny",
        "destination": "los angeles, ca",
        "api_key": user.api_key
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v0/road_trip", headers: headers, params: JSON.generate(road_trip: road_trip_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data]).to be_a(Hash)
      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to eq('null')
      expect(json[:data]).to have_key(:type)
      expect(json[:data][:type]).to eq('road_trip')
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to be_a(Hash)
      expect(json[:data][:attributes]).to have_key(:start_city)
      expect(json[:data][:attributes][:start_city]).to eq('new york, ny')
      expect(json[:data][:attributes]).to have_key(:end_city)
      expect(json[:data][:attributes][:end_city]).to eq('los angeles, ca')
      expect(json[:data][:attributes]).to have_key(:travel_time)
      expect(json[:data][:attributes]).to have_key(:weather_at_eta)
      expect(json[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
      expect(json[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(json[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
    end

    it 'returns an errors message if the api key is invalid' do
      road_trip_params = {
        "origin": "new york, ny",
        "destination": "los angeles, ca",
        "api_key": "invalidkey"
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v0/road_trip", headers: headers, params: JSON.generate(road_trip: road_trip_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:error]).to eq('Invalid API key')
    end
  
    it 'returns an errors message if the api key is not provided' do
      road_trip_params = {
        "origin": "new york, ny",
        "destination": "los angeles, ca"
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v0/road_trip", headers: headers, params: JSON.generate(road_trip: road_trip_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
      
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:error]).to eq('Invalid API key')
    end

    it 'returns an errors message if the route is impossible' do
      user = create(:user)
      road_trip_params = {
        "origin": "new york, ny",
        "destination": "london, uk",
        "api_key": user.api_key
      }

      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v0/road_trip", headers: headers, params: JSON.generate(road_trip: road_trip_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data]).to be_a(Hash)
      expect(json[:data]).to have_key(:id)
      expect(json[:data][:id]).to eq('null')
      expect(json[:data]).to have_key(:type)
      expect(json[:data][:type]).to eq('road_trip')
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:attributes]).to be_a(Hash)
      expect(json[:data][:attributes]).to have_key(:start_city)
      expect(json[:data][:attributes][:start_city]).to eq('new york, ny')
      expect(json[:data][:attributes]).to have_key(:end_city)
      expect(json[:data][:attributes][:end_city]).to eq('london, uk')
      expect(json[:data][:attributes]).to have_key(:travel_time)
      expect(json[:data][:attributes][:travel_time]).to eq('impossible route')
      expect(json[:data][:attributes]).to have_key(:weather_at_eta)
     expect(json[:data][:attributes][:weather_at_eta]).to eq({})
    end
  end
end