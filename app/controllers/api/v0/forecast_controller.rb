class Api::V0::ForecastController < ApplicationController
  def index 
    response = MapquestService.new.get_lat_lng(params[:location])

    lat = response[:results][0][:locations][0][:latLng][:lat]
    lon = response[:results][0][:locations][0][:latLng][:lng]
    
    new_response = WeatherService.new.get_weather(lat, lon)
    require 'pry'; binding.pry
  end
end