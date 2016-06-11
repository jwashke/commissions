require 'csv'

namespace :import_csv do
  desc "loads new listings into database"
  task listings: :environment do
    contents = CSV.open "tmp/data/Full\ Export.csv", headers: true
    Listing.update_all(status: "inactive")
    ActiveRecord::Base.transaction do
      contents.each do |l|
        record = Listing.where(mls_number: l["MLS Number"]).first_or_initialize do |listing|
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
          listing.save!
        end
        puts "made record #{record.mls_number}"
      end
    end
  end
end
