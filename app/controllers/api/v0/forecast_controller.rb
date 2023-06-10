class Api::V0::ForecastController < ApplicationController
  def index 
    response = MapquestService.new.get_lat_lng(params[:location])

    lat = response[:results][0][:locations][0][:latLng][:lat]
    lon = response[:results][0][:locations][0][:latLng][:lng]
    
    new_response = Faraday.get("http://api.weatherapi.com/v1/forecast.json?key=#{ENV['WEATHER_KEY']}&q=#{lat},#{lon}&days=5&aqi=no&alerts=no']}")
    new_parsed = JSON.parse(new_response.body, symbolize_names: true)
    require 'pry'; binding.pry
  end
end