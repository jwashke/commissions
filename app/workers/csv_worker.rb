class CsvWorker
  include Sidekiq::Worker

  def perform(new_listings)
    Listing.create_listings(new_listings)
  end
end
