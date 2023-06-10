class MapquestService
  def get_lat_lng(location)
    get_url("/geocoding/v1/address?location=#{location}")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://www.mapquestapi.com') do |faraday|
      faraday.params['key'] = ENV['MAPQUEST_KEY']
    end
  end
end