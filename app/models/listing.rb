class Listing < ActiveRecord::Base

  def self.all_cached
    Rails.cache.fetch('listings') do
      self.where(status: "Active")
    end
  end

  def streetview_available?
    image = Faraday.get("https://maps.googleapis.com/maps/api/streetview?size=600x300&location=#{self.latitude},#{self.longitude}&pitch=-0.76&key=#{ENV['STREET_VIEW_KEY']}")
    if image.env.response_headers["content-length"].to_i < 6000
      self.update(streetview_available: false)
    else
      self.update(streetview_available: true)
    end
    return self.streetview_available
  end
end
