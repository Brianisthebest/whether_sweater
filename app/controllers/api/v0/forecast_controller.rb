class Api::V0::ForecastController < ApplicationController
  def index 
    if params[:location].nil? || params[:location].empty?
      render json: {error: 'No location provided'}, status: 400
    else
      forecast = ForecastFacade.new.get_forecast(params[:location])
      render json: ForecastSerializer.new(forecast)
    end
  end
end