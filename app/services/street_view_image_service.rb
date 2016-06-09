
class StreetViewImageService

  def initialize
    @connection = Faraday.new "https://maps.googleapis.com/maps/api"
  end

  def get_image(lat, lng)
    location = "#{lat},#{lng}"
    @connection.params["location"] = location
    @connection.params["size"] = "600x300"
    @connection.params["key"] = ENV["STREET_VIEW_KEY"]
    @connection.get  "streetview"
  end
end
