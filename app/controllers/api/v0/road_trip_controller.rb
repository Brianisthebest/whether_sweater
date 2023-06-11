class Api::V0::RoadTripController < ApplicationController
  def create
    response = Faraday.get("https://www.mapquestapi.com/directions/v2/route?key=#{ENV['MAPQUEST_KEY']}&from=#{params[:road_trip][:origin]}&to=#{params[:destination]}")
    json = JSON.parse(response.body, symbolize_names: true)
    
    # time = Time.now + json[:route][:realTime]
    require 'pry'; binding.pry
    # json[:route][:locations][1][:latLng]
  end
end

#https://www.mapquestapi.com/directions/v2/route?key=RuV20IK7DKLWWRKnJ5EsRojHxjqxylDj&from=new york, ny&to=los angeles, ca