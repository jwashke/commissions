class ListingsController < ApplicationController
  # before_action :require_login

  def show
    @listing = Listing.find_by(mls_number: params[:mls_number])
  end
end
