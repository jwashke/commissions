class ListingsController < ApplicationController
  before_action :require_user_and_user_signed_docs

  def index
  end

  def show
    listing = Listing.find_by(mls_number: params[:mls_number])
    @listing = ListingShow.new(listing)
  end
end
