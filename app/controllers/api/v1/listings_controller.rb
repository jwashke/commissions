class Api::V1::ListingsController < Api::V1::ApiController
  def index
    listings = Rails.cache.fetch("all-items", expires_at: Date.tomorrow) do
      Listing.all
    end
    respond_with listings
  end
end
