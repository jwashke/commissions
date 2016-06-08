require 'csv'

namespace :import_csv do
  desc "loads new listings into database"
  task listings: :environment do
    contents = CSV.open "tmp/data/Full\ Export.csv", headers: true
    contents.each do |l|
      prev_record = Listing.find_by(mls_number: l["MLS Number"])
      if prev_record
        if prev_record.last_change_timestamp != DateTime.strptime(l["Last Change Timestamp"], "%m/%d/%Y %I:%M:%S %p")
          prev_record.update(
            mls_number: l["MLS Number"],
            last_change_timestamp: DateTime.strptime(l["Last Change Timestamp"], "%m/%d/%Y %I:%M:%S %p"),
            property_type: l["Type"],
            status: l["Status"],
            list_price: l["List Price"],
            street_number: l["Street #"],
            street_dir: l["Street Dir"],
            street_name: l["Street Name"],
            street_type: l["Street Type"],
            unit_number: l["Unit #"],
            building_number: l["Building #"],
            city: l["City"],
            state: l["State"],
            zip_code: l["Zip Code"],
            county: l["County"],
            parcel_number: l["Parcel Number"],
            locale: l["Locale"],
            complex_name: l["Complex Name"]
          )
          puts "updated listing #{prev_record.id}: #{prev_record.mls_number}"
        end
      else
        listing = Listing.create!(
          mls_number: l["MLS Number"],
          last_change_timestamp: DateTime.strptime(l["Last Change Timestamp"], "%m/%d/%Y %I:%M:%S %p"),
          property_type: l["Type"],
          status: l["Status"],
          list_price: l["List Price"],
          street_number: l["Street #"],
          street_dir: l["Street Dir"],
          street_name: l["Street Name"],
          street_type: l["Street Type"],
          unit_number: l["Unit #"],
          building_number: l["Building #"],
          city: l["City"],
          state: l["State"],
          zip_code: l["Zip Code"],
          county: l["County"],
          parcel_number: l["Parcel Number"],
          locale: l["Locale"],
          complex_name: l["Complex Name"]
        )
        puts "created listing #{listing.id}: #{listing.mls_number}"
      end
    end
  end
end
