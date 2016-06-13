class HomeController < ApplicationController
  def index
    if user_signed_in? && current_user.signed_docs?
      redirect_to listings_path
    elsif user_signed_in?
      redirect_to signing_path
    end
  end
end
