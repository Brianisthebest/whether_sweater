class Api::V0::ForecastController < ApplicationController
  def index
    response = Faraday.get("https://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['MAPQUEST_KEY']}&location=#{params[:location]}")
    parsed = JSON.parse(response.body, symbolize_names: true)
    lat = parsed[:results][0][:locations][0][:latLng][:lat]
    lon = parsed[:results][0][:locations][0][:latLng][:lng]

    new_response = Faraday.get("http://api.weatherapi.com/v1/forecast.json?key=#{ENV['WEATHER_KEY']}&q=#{lat},#{lon}&days=5&aqi=no&alerts=no']}")
    new_parsed = JSON.parse(new_response.body, symbolize_names: true)
    require 'pry'; binding.pry
  end
end