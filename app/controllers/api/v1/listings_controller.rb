class Api::V1::ListingsController < Api::V1::ApiController
  def index
    respond_with Listing.all
  end
end