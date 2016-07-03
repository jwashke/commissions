class CSVWorker
  include Sidekiq::Worker

  def perform(new_listings, import_id)
    json_listings = CSVService.get_listings(new_listings)
    Listing.create_listings(json_listings, import_id)
  end
end
