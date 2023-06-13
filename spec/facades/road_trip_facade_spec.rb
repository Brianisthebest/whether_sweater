require 'rails_helper'

RSpec.describe RoadTripFacade do
  it 'returns a road_trip object', :vcr do
    road_trip = RoadTripFacade.new.get_road_trip('new york, ny', 'los angeles, ca')

    expect(road_trip).to be_a(RoadTrip)
    expect(road_trip.id).to eq('null')
    expect(road_trip.type).to eq('road_trip')
    expect(road_trip.start_city).to eq('new york, ny')
    expect(road_trip.end_city).to eq('los angeles, ca')
    expect(road_trip.travel_time).to be_a(String)
    expect(road_trip.weather_at_eta).to be_a(Hash)
    expect(road_trip.weather_at_eta).to have_key(:datetime)
    expect(road_trip.weather_at_eta).to have_key(:temperature)
    expect(road_trip.weather_at_eta).to have_key(:conditions)
  end
end