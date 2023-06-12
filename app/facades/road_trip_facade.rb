require 'rounding'

class RoadTripFacade
  def get_road_trip(origin, destination)
    trip = MapquestService.new.get_directions(origin, destination)

    if trip[:info][:statuscode] == 402
      road_trip = RoadTrip.new(origin, destination, 'impossible route', {})
    else
      lat = trip[:route][:locations][1][:latLng][:lat]
      lng = trip[:route][:locations][1][:latLng][:lng]
      travel_time = trip[:route][:formattedTime]
  
      time = Time.now + trip[:route][:realTime]
      rounded_time = time.round_to(60*60)
      date = time.strftime("%Y-%m-%d")
      arrival_time = rounded_time.strftime("%H:%M")
  
      full_time = date + ' ' + arrival_time
      
      weather = WeatherService.new.get_weather(lat, lng)
  
      weather[:forecast][:forecastday].map do |day|
        if day[:date] == date
          day[:hour].map do |hour|
            if hour[:time] == full_time
              @weather_at_eta = {
                  "datetime": full_time,
                  "temperature": hour[:temp_f],
                  "conditions": hour[:condition][:text]
              }
            end
          end
        end
      end
  
      RoadTrip.new(origin, destination, travel_time, @weather_at_eta)
    end
  end
end