class ListingsController < ApplicationController

  before_action :require_user_and_user_signed_docs

  def index
    @cities = Listing.order('city ASC').uniq.pluck(:city)
    @property_types = Listing.order('property_type ASC').uniq.pluck(:property_type)
    @bedrooms = Listing.order('total_bedrooms ASC').uniq.pluck(:total_bedrooms)
    @bathrooms = Listing.order('total_baths ASC').uniq.pluck(:total_baths)
  end

  def show
    listing = Listing.find_by(mls_number: params[:mls_number])
    @listing = ListingShow.new(listing)
  end
end
