class Api::V0::RoadTripController < ApplicationController
  def create
    # trip = MapquestService.new.get_directions(params[:road_trip][:origin], params[:road_trip][:destination])

    # lat = trip[:route][:locations][1][:latLng][:lat]
    # lng = trip[:route][:locations][1][:latLng][:lng]

    # weather = WeatherService.new.get_weather(lat, lng)


    # time = Time.now + trip[:route][:realTime]
    # date = time.strftime("%Y-%m-%d")
    # year = date.split('-')[0].to_i
    # month = date.split('-')[1].to_i
    # day = date.split('-')[2].to_i
    # new_time = time.to_s.split[1].split(':').first.to_i

    # response = WeatherService.new.get_future_weather(lat, lng, year, month, day, new_time)
    require 'pry'; binding.pry
    # time = Time.now + json[:route][:realTime]
    # require 'pry'; binding.pry
    # json[:route][:locations][1][:latLng]
  end
end

#https://www.mapquestapi.com/directions/v2/route?key=RuV20IK7DKLWWRKnJ5EsRojHxjqxylDj&from=new york, ny&to=los angeles, ca