class HomeController < ApplicationController
  def index
    redirect_to listings_path if current_user
  end
end
