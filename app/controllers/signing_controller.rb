class SigningController < ApplicationController
  before_action :check_user_and_unsigned_docs

  def new
  end

  def create
    current_user.sign_docs
    redirect_to listings_path
  end

  private

  def check_user_and_unsigned_docs
    if user_signed_in? && current_user.signed_docs
      redirect_to listings_path
    elsif !user_signed_in?
      redirect_to root_path
    end
  end
end
