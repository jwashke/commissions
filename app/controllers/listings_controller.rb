class ListingsController < ApplicationController
  def index
    @listings = Listing.all
    @hash = Gmaps4rails.build_markers(@listings) do |listing, marker|
      marker.lat listing.latitude
      marker.lng listing.longitude
    end
  end

  def show
    @listing = Listing.find_by(mls_number: params[:mls_number])
    @hash = Gmaps4rails.build_markers(@listing) do |listing, marker|
      marker.lat listing.latitude
      marker.lng listing.longitude
    end
  end
end
