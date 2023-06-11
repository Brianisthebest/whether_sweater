class WeatherService
  def get_weather(lat, lng)
    get_url("/v1/forecast.json?q=#{lat},#{lng}&days=5&aqi=no&alerts=no")
  end
  
  # Only works if the date is 14 days into the future :( wish I had seen that sooner.
  # def get_future_weather(lat, lon, year, month, day, hour)
  #   get_url("/v1/future.json?q=#{lat},#{lon}&dt=#{year}-#{month}-#{day}&time=#{hour}")
  # end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'http://api.weatherapi.com') do |faraday|
      faraday.params['key'] = ENV['WEATHER_KEY']
    end
  end
end