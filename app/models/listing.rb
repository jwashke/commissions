require 'csv'
class Listing < ActiveRecord::Base

  def self.all_cached
    Rails.cache.fetch('listings') do
      self.where(status: "Active")
    end
  end

  def self.create_listings(listings)
    listings = JSON.parse(listings)
    ActiveRecord::Base.transaction do
      self.update_all(status: "Inactive")
      listings.each do |l|
        listing = self.where(mls_number: l["mls_number"]).first_or_initialize
        listing.mls_number = l["mls_number"]
        listing.last_change_timestamp = DateTime.strptime(l["last_change_timestamp"], "%m/%d/%Y %I:%M:%S %p") if l["last_change_timestamp"]
        listing.property_type = l["type"]
        listing.status = l["status"]
        listing.list_price = l["list_price"]
        listing.street_number = l["street_#"]
        listing.street_dir = l["street_dir"]
        listing.street_name = l["street_name"]
        listing.street_type = l["street_type"]
        listing.unit_number = l["unit_#"]
        listing.building_number = l["building_#"]
        listing.city = l["city"]
        listing.state = l["state"]
        listing.zip_code = l["zip_code"]
        listing.county = l["county"]
        listing.parcel_number = l["parcel_number"]
        listing.locale = l["locale"]
        listing.complex_name = l["complex_name"]
        listing.latitude = l["latitude"]
        listing.longitude = l["longitude"]
        listing.public_remarks = l["public_remarks"]
        listing.total_baths = l["total_baths"]
        listing.total_bedrooms = l["total_bedrooms"]
        listing.square_feet = l["sqft_total"]
        listing.lot_square_acres = l["lot_size_acres"]
        listing.buyer_agency_compensation = l["buyer_agency_compensation"]
        listing.listing_agent_name = l["listing_agent_name"]
        listing.listing_agent_phone = l["listing_agent_direct_work_phone"]
        listing.listing_agent_email = l["listing_agent_email"]
        listing.transaction_broker_compensation = l["transaction_broker_compensation"]
        listing.save
      end
    end
    Import.last.update(
      total_time: (Time.now.to_f - Import.last.time_started.to_f),
      current_quantity_active: self.where(status: "Active").count
    )
    Rails.cache.clear
  end

  # def self.new_import(file)
  #   import = Import.create(
  #     time_started: Time.now,
  #     prev_quantity_active: self.where(status: "Active").count
  #   )
  #   create_csv(file.path)
  #   import(import)
  #   Rails.cache.clear
  # end

  def streetview_available?
    image = StreetViewImageService.new.get_image(latitude, longitude)
    if image.env.response_headers["content-length"].to_i < 6000
      self.update(streetview_available: false)
    else
      self.update(streetview_available: true)
    end
    return self.streetview_available
  end

private

end
