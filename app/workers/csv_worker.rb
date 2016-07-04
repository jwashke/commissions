class CSVWorker
  include Sidekiq::Worker

  def perform(json_listings, import_id)
    Listing.create_listings(json_listings, import_id)
  end
end
