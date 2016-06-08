require 'csv'

namespace :import_csv do
  desc "loads new listings into database"
  task listings: :environment do
    contents = CSV.open "tmp/data/Full\ Export.csv", headers: true
    Listing.update_all(status: "inactive")
    ActiveRecord::Base.transaction do
      contents.each do |l|
        # listing = Listing.first_or_initialize(mls_number: l["MLS Number"])
        # listing.update!(
        #   mls_number: l["MLS Number"],
        #   last_change_timestamp: DateTime.strptime(l["Last Change Timestamp"], "%m/%d/%Y %I:%M:%S %p"),
        #   property_type: l["Type"],
        #   status: l["Status"],
        #   list_price: l["List Price"],
        #   street_number: l["Street #"],
        #   street_dir: l["Street Dir"],
        #   street_name: l["Street Name"],
        #   street_type: l["Street Type"],
        #   unit_number: l["Unit #"],
        #   building_number: l["Building #"],
        #   city: l["City"],
        #   state: l["State"],
        #   zip_code: l["Zip Code"],
        #   county: l["County"],
        #   parcel_number: l["Parcel Number"],
        #   locale: l["Locale"],
        #   complex_name: l["Complex Name"],
        #   latitude: l["Latitude"],
        #   longitude: l["Longitude"]
          # public_remarks: l["Public Remarks"]
        # )
        prev_record = Listing.find_by(mls_number: l["MLS Number"])
        if prev_record
          listing = prev_record
          if listing.last_change_timestamp != DateTime.strptime(l["Last Change Timestamp"], "%m/%d/%Y %I:%M:%S %p")
            listing.update(
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
              complex_name: l["Complex Name"],
              latitude: l["Latitude"],
              longitude: l["Longitude"],
              public_remarks: l["Public Remarks"]

            )
            puts "updated listing #{listing.id}: #{listing.mls_number}"
          else
            listing.update(
              status: l["Status"]
            )
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
            complex_name: l["Complex Name"],
            latitude: l["Latitude"],
            longitude: l["Longitude"],
            public_remarks: l["Public Remarks"]

          )
          puts "created listing #{listing.id}: #{listing.mls_number}"
        end
      end
    end
  end
end
