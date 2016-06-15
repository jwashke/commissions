require 'csv'

class CsvImporter
  def initialize(filepath)
    CSV.open("tmp/data/listings", 'w') do |writer|
      CSV.foreach(filepath, headers: true) do |listing|
        writer << listing
      end
    end
  end

  def run
    import = Import.create(
      time_started: Time.now,
      prev_quantity_active: Listing.where(status: "Active").count
    )
    Listing.update_all(status: "inactive")
    ActiveRecord::Base.transaction do
    CSV.foreach(@filepath, headers: true) do |l|
        listing = Listing.where(mls_number: l["MLS Number"]).first_or_initialize
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
        listing.save!
      end
    end
    import.update(
      total_time: (Time.now.to_f - import.time_started.to_f),
      current_quantity_active: Listing.where(status: "Active").count
    )
    Rails.cache.clear
  end
end