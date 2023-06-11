class Api::V0::RoadTripController < ApplicationController
  def create
    road_trip = RoadTripFacade.new.get_road_trip(params[:road_trip][:origin], params[:road_trip][:destination])
    require 'pry'; binding.pry
    render json: RoadTripSerializer.new(road_trip), status: 201
  end
end