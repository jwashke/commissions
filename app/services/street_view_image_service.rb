
class StreetViewImageService
  def initialize
    @conn = Faraday.new(url: "https://maps.googleapis.com/maps/api")
  end

  def get_image(lat, lng)
    @conn.get "streetview", {
      size: "600x300",
      location: "#{lat},#{lng}",
      key: ENV['GOOGLE_MAPS_API_KEY'],
      pitch: "-0.76"
    }
  end
end
