require 'csv'
class Listing < ActiveRecord::Base

  def self.all_cached
    Rails.cache.fetch('listings') do
      self.where(status: "Active")
    end
  end

  def self.new_import(file)
    import = Import.create(
      time_started: Time.now,
      prev_quantity_active: self.where(status: "Active").count
    )
    create_csv(file.path)
    import(import)
    Rails.cache.clear
  end

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

  def self.create_csv(file_path)
    new_csv = CSV.open("lib/new.csv", mode = "wb")
    contents = CSV.open file_path
    contents.each do |listing|
      new_csv << listing
    end
    new_csv.close
  end

  def self.import(import)
    self.update_all(status: "inactive")
    contents = CSV.open "lib/new.csv", headers: true
    ActiveRecord::Base.transaction do
      contents.each do |l|
        listing = self.where(mls_number: l["MLS Number"]).first_or_initialize
        listing.mls_number = l["MLS Number"]
        listing.last_change_timestamp = DateTime.strptime(l["Last Change Timestamp"], "%m/%d/%Y %I:%M:%S %p")
        listing.property_type = l["Type"]
        listing.status = l["Status"]
        listing.list_price = l["List Price"]
        listing.street_number = l["Street #"]
        listing.street_dir = l["Street Dir"]
        listing.street_name = l["Street Name"]
        listing.street_type = l["Street Type"]
        listing.unit_number = l["Unit #"]
        listing.building_number = l["Building #"]
        listing.city = l["City"]
        listing.state = l["State"]
        listing.zip_code = l["Zip Code"]
        listing.county = l["County"]
        listing.parcel_number = l["Parcel Number"]
        listing.locale = l["Locale"]
        listing.complex_name = l["Complex Name"]
        listing.latitude = l["Latitude"]
        listing.longitude = l["Longitude"]
        listing.public_remarks = l["Public Remarks"]
        listing.total_baths = l["Total Baths"]
        listing.total_bedrooms = l["Total Bedrooms"]
        listing.square_feet = l["SqFt Total"]
        listing.lot_square_acres = l["Lot Size Acres"]
        listing.buyer_agency_compensation = l["Buyer Agency Compensation"]
        listing.listing_agent_name = l["Listing Agent Name"]
        listing.listing_agent_phone = l["Listing Agent Direct Work Phone"]
        listing.listing_agent_email = l["Listing Agent Email"]
        listing.transaction_broker_compensation = l["Transaction Broker Compensation"]
        listing.save
      end
    end
    import.update(
      total_time: (Time.now.to_f - import.time_started.to_f),
      current_quantity_active: self.where(status: "Active").count
    )
  end
end
