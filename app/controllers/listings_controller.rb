class ListingsController < ApplicationController
  def show
    @listing = Listing.find_by(mls_number: params[:mls_number])
  end
end
