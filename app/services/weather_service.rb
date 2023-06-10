class WeatherService
  def get_weather(lat, lng)
    get_url("/v1/forecast.json?&q=#{lat},#{lng}&days=5&aqi=no&alerts=no")
  end

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