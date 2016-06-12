require 'rails_helper'

RSpec.describe Api::V1::ListingsController do
  describe "GET Index", type: :controller do
    it "can visit index" do
      Listing = Listing.create(mls_number: 1234567)

      get "index", format: :json

      expect(response).to be_success
      binding.pry
    end
