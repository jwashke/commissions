class CSVWorker
  include Sidekiq::Worker

  def perform(new_listings, import_id)
    Listing.create_listings(new_listings, import_id)
  end
end
