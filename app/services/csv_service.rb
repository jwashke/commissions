class CSVService
  def self.get_listings(file_path)
    new_listings = SmarterCSV.process(file_path)
    new_listings.to_json
  end
end
