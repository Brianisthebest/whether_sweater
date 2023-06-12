class Api::V1::BooksController < ApplicationController
  def index
    books = Faraday.get("https://openlibrary.org/search.json?q=#{params[:location]}&fields=*,availability&limit=#{params[:quantity]}")
    mapquest = MapquestService.new.get_lat_lng(params[:location])
    lat = mapquest[:results][0][:locations][0][:latLng][:lat]
    lng = mapquest[:results][0][:locations][0][:latLng][:lng]
    weather = WeatherService.new.get_weather(lat, lng)
    json = JSON.parse(books.body, symbolize_names: true)
    require 'pry'; binding.pry
  end
end