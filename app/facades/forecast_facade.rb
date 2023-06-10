class ForecastFacade
  def get_forecast(location)
    mapquest = mapquest_service.get_lat_lng(location)
    weather = weather_service.get_weather(mapquest[:results][0][:locations][0][:latLng][:lat], mapquest[:results][0][:locations][0][:latLng][:lng])
  
    current_weather = {
      last_updated: weather[:current][:last_updated],
      temperature: weather[:current][:temp_f],
      feels_like: weather[:current][:feelslike_f],
      humidity: weather[:current][:humidity],
      uvi: weather[:current][:uv],
      visibility: weather[:current][:vis_miles],
      condition: weather[:current][:condition][:text],
      icon: weather[:current][:condition][:icon]
    }

    daily_weather = weather[:forecast][:forecastday].map do |day|
      {
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end

    hourly_weather = weather[:forecast][:forecastday].first[:hour].map do |hour| 
      {
        time: hour[:time].split[1],
        temperature: hour[:temp_f],
        conditions: hour[:condition][:text],
        icon: hour[:condition][:icon]
      }
    end

    Forecast.new(current_weather, daily_weather, hourly_weather)
  end

  def mapquest_service
    @mapquest_service ||= MapquestService.new
  end

  def weather_service
    @weather_service ||= WeatherService.new
  end
end