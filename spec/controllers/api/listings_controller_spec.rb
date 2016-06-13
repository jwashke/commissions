require 'rails_helper'

RSpec.describe Api::V1::ListingsController do
  describe "GET Index", type: :controller do
    it "can visit index" do
      user = create(:signed_user)
      login_as user, scope: :user
      listing = Listing.create(mls_number: 1234567)
      binding.pry

      get "index", format: :json

      expect(response).to be_success
    end
  end
end
