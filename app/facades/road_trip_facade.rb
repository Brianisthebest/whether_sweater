class RoadTripFacade
  def get_road_trip(origin, destination)
    trip = MapquestService.new.get_directions(origin, destination)
    lat = trip[:route][:locations][1][:latLng][:lat]
    lng = trip[:route][:locations][1][:latLng][:lng]
    travel_time = trip[:route][:formattedTime]

    time = Time.now + trip[:route][:realTime]
    date = time.strftime("%Y-%m-%d")

    weather = WeatherService.new.get_weather(lat, lng)
    
    weather[:forecast][:forecastday].map do |day|
      if day[:date] == date
        @weather_at_eta = {
            "datetime": day[:date],
            "temperature": day[:day][:avgtemp_f],
            "conditions": day[:day][:condition][:text]
        }
      end
    end

    RoadTrip.new(origin, destination, travel_time, @weather_at_eta)
  end
end