class CSVService
  def self.get_listings(file_path)
    Import.create(
      time_started: Time.now,
      prev_quantity_active: Listing.where(status: "Active").count
    )
    new_listings = SmarterCSV.process(file_path)
    new_listings.to_json
  end
end
